# frozen_string_literal: true

class TerminalChannel < ApplicationCable::Channel
  # Store active container sessions
  @@sessions = {}

  def subscribed
    session_id = params[:session_id] || SecureRandom.uuid
    image = params[:image] || 'ubuntu:22.04'
    enable_docker = params[:enable_docker] == true || params[:enable_docker] == 'true'

    @session_id = session_id
    @enable_docker = enable_docker
    stream_from "terminal_#{session_id}"

    Rails.logger.info "Terminal channel subscribed: session=#{session_id}, image=#{image}, enable_docker=#{enable_docker}"

    # Start container in background thread
    Thread.new do
      start_container(session_id, image, enable_docker)
    end
  end

  def unsubscribed
    Rails.logger.info "Terminal channel unsubscribed: session=#{@session_id}"
    stop_container(@session_id)
  end

  def receive(data)
    return unless @session_id

    if data['input']
      send_input_to_container(@session_id, data['input'])
    elsif data['resize']
      resize_container(@session_id, data['resize'])
    end
  end

  private

  def start_container(session_id, image, enable_docker = false)
    begin
      # Check if Docker is available
      unless system('docker info > /dev/null 2>&1')
        broadcast_output(session_id, "\r\n\x1b[31mError: Docker is not running or not installed.\x1b[0m\r\n")
        broadcast_output(session_id, "\x1b[33mPlease ensure Docker Desktop is running and try again.\x1b[0m\r\n")
        return
      end

      container_name = "terminal_#{session_id}"

      # Stop and remove existing container if any
      system("docker rm -f #{container_name} 2>/dev/null")

      # Build container command based on whether Docker is enabled
      if enable_docker
        # Docker-enabled container: mount Docker socket, use docker:cli image
        # This allows running docker commands inside the container
        cmd = "docker run -d --name #{container_name} " \
              "-v /var/run/docker.sock:/var/run/docker.sock " \
              "--memory 512m " \
              "--cpus 1 " \
              "--pids-limit 100 " \
              "-w /root " \
              "docker:cli " \
              "tail -f /dev/null"
      else
        # Standard Linux terminal: isolated, read-only
        cmd = "docker run -d --name #{container_name} " \
              "--network none " \
              "--memory 256m " \
              "--cpus 0.5 " \
              "--pids-limit 50 " \
              "--read-only " \
              "--tmpfs /tmp:size=64m " \
              "--tmpfs /home/user:size=32m " \
              "-w /home/user " \
              "#{image} " \
              "tail -f /dev/null"
      end

      result = system(cmd)

      unless result
        broadcast_output(session_id, "\r\n\x1b[31mFailed to start container.\x1b[0m\r\n")
        return
      end

      Rails.logger.info "Container started: #{container_name}"

      # Start interactive shell using docker exec with PTY
      # Use /bin/sh for Alpine-based images (docker:cli), /bin/bash for others
      shell = enable_docker ? "/bin/sh" : "/bin/bash"
      start_shell(session_id, container_name, shell)

    rescue StandardError => e
      Rails.logger.error "Failed to start container: #{e.message}"
      broadcast_output(session_id, "\r\n\x1b[31mError: #{e.message}\x1b[0m\r\n")
    end
  end

  def start_shell(session_id, container_name, shell = "/bin/bash")
    require 'pty'
    require 'io/console'

    begin
      # Start shell in container
      master, slave = PTY.open

      pid = Process.spawn(
        "docker", "exec", "-it", container_name, shell,
        in: slave,
        out: slave,
        err: slave
      )

      slave.close

      # Store session info
      @@sessions[session_id] = {
        master: master,
        pid: pid,
        container_name: container_name
      }

      # Read output from PTY and broadcast to client
      Thread.new do
        begin
          loop do
            break unless @@sessions[session_id]

            # Use select to check for available data
            ready = IO.select([master], nil, nil, 0.1)

            if ready
              begin
                data = master.read_nonblock(4096)
                broadcast_output(session_id, data) if data && !data.empty?
              rescue IO::WaitReadable
                # No data available, continue
              rescue EOFError
                break
              end
            end
          end
        rescue StandardError => e
          Rails.logger.error "PTY read error: #{e.message}"
        ensure
          cleanup_session(session_id)
        end
      end

    rescue StandardError => e
      Rails.logger.error "Failed to start shell: #{e.message}"
      broadcast_output(session_id, "\r\n\x1b[31mFailed to start shell: #{e.message}\x1b[0m\r\n")

      # Fallback: Try simpler exec without PTY
      start_simple_shell(session_id, container_name)
    end
  end

  def start_simple_shell(session_id, container_name)
    # Simpler fallback using IO.popen
    begin
      io = IO.popen(["docker", "exec", "-i", container_name, "/bin/bash"], "r+")

      @@sessions[session_id] = {
        io: io,
        container_name: container_name
      }

      # Send initial prompt
      broadcast_output(session_id, "user@linux:~$ ")

      # Read output in background
      Thread.new do
        begin
          while line = io.gets
            broadcast_output(session_id, line)
          end
        rescue StandardError => e
          Rails.logger.error "IO read error: #{e.message}"
        ensure
          cleanup_session(session_id)
        end
      end

    rescue StandardError => e
      Rails.logger.error "Failed to start simple shell: #{e.message}"
      broadcast_output(session_id, "\r\n\x1b[31mFailed to start shell.\x1b[0m\r\n")
    end
  end

  def send_input_to_container(session_id, input)
    session = @@sessions[session_id]
    return unless session

    begin
      if session[:master]
        session[:master].write(input)
      elsif session[:io]
        session[:io].write(input)
        session[:io].flush
      end
    rescue StandardError => e
      Rails.logger.error "Failed to send input: #{e.message}"
    end
  end

  def resize_container(session_id, dimensions)
    session = @@sessions[session_id]
    return unless session && session[:master]

    begin
      cols = dimensions['cols'] || 80
      rows = dimensions['rows'] || 24

      # Resize PTY
      session[:master].winsize = [rows, cols]
    rescue StandardError => e
      Rails.logger.error "Failed to resize: #{e.message}"
    end
  end

  def stop_container(session_id)
    cleanup_session(session_id)
  end

  def cleanup_session(session_id)
    session = @@sessions.delete(session_id)
    return unless session

    begin
      # Close PTY or IO
      session[:master]&.close rescue nil
      session[:io]&.close rescue nil

      # Kill process if running
      if session[:pid]
        Process.kill('TERM', session[:pid]) rescue nil
      end

      # Stop and remove container
      if session[:container_name]
        Thread.new do
          system("docker rm -f #{session[:container_name]} 2>/dev/null")
          Rails.logger.info "Container removed: #{session[:container_name]}"
        end
      end
    rescue StandardError => e
      Rails.logger.error "Cleanup error: #{e.message}"
    end
  end

  def broadcast_output(session_id, output)
    ActionCable.server.broadcast("terminal_#{session_id}", { output: output })
  end
end
