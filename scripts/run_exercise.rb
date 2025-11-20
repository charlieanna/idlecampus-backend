#!/usr/bin/env ruby
require 'json'
require 'open3'
require 'timeout'
require_relative '../lib/exercise_validation'

# Usage:
#   ruby backend/scripts/run_exercise.rb '{"exercise_type":"terminal","exercise_data":{...}}'
#   ruby backend/scripts/run_exercise.rb /path/to/exercise.json
#   echo '{...}' | ruby backend/scripts/run_exercise.rb -

def parse_payload(argv)
  if argv[0] == '-'
    JSON.parse($stdin.read)
  elsif argv[0] && File.exist?(argv[0])
    JSON.parse(File.read(argv[0], encoding: 'UTF-8'))
  else
    JSON.parse(argv[0] || '{}')
  end
end

def run_command(cmd, cwd: nil, env: {}, timeout_sec: 60)
  output = ""
  status = nil
  timed_out = false
  Dir.chdir(cwd || Dir.pwd) do
    begin
      Timeout.timeout(timeout_sec.to_i) do
        Open3.popen3(env, %Q{/bin/bash -lc #{cmd.inspect}}) do |stdin, stdout, stderr, wait_thr|
          stdin.close
          out_t = Thread.new { stdout.read }
          err_t = Thread.new { stderr.read }
          output = (out_t.value.to_s + err_t.value.to_s)
          status = wait_thr.value
        end
      end
    rescue Timeout::Error
      timed_out = true
    end
  end
  [output, status, timed_out]
end

payload = parse_payload(ARGV)
etype = payload['exercise_type'] || payload[:exercise_type]
edata = payload['exercise_data'] || payload[:exercise_data] || {}

cmd = nil
case etype
when 'terminal'
  cmd = edata['command'] || edata[:command]
when 'sandbox'
  cmd = edata['run'] || edata[:run]
when 'code'
  tests = edata['tests'] || edata[:tests] || {}
  cmd = tests['run'] || tests[:run]
end

unless cmd && cmd.is_a?(String) && !cmd.strip.empty?
  puts({ pass: false, error: 'No command/run specified', payload: payload }.to_json)
  exit 1
end

cwd = edata['cwd'] || edata[:cwd]
timeout_sec = edata['timeout_sec'] || edata[:timeout_sec] || 60
env = edata['env'] || edata[:env] || {}
validation = edata['validation'] || edata[:validation] || {}
if etype == 'code' && validation.empty?
  # Sensible defaults for code tests: expect PASS and no panic
  validation = { 'must_include' => ['PASS'], 'must_not_include' => ['panic:', 'FAIL'] }
end

# Wrap Kubernetes commands in ephemeral namespace for code/sandbox
if %w[code sandbox terminal].include?(etype) && cmd.is_a?(String) && cmd.include?('kubectl ')
  cmd = k8s_ephemeral_namespace_wrap(cmd)
end

output, status, timed_out = run_command(cmd, cwd: cwd, env: env, timeout_sec: timeout_sec)

result = ExerciseValidation.validate(output, {
  must_include: validation['must_include'] || validation[:must_include],
  must_not_include: validation['must_not_include'] || validation[:must_not_include]
})

pass = result.pass && !timed_out && (status.nil? || status.success?)

puts({
  pass: pass,
  timed_out: timed_out,
  exit_status: (status&.exitstatus),
  messages: result.messages,
  output: output
}.to_json)

def k8s_ephemeral_namespace_wrap(cmd)
  return cmd unless cmd.is_a?(String) && cmd.include?('kubectl ')
  ns = "mlns-#{Time.now.to_i}-#{rand(1000)}"
  modified = cmd.gsub(/kubectl\s+/, 'kubectl -n $NS ')
  preflight = "if ! command -v kubectl >/dev/null 2>&1; then echo 'ERROR: kubectl not installed'; exit 127; fi; kubectl version --client >/dev/null 2>&1 || echo 'WARNING: kubectl client version unavailable'; kubectl cluster-info >/dev/null 2>&1 || echo 'WARNING: cluster info unavailable (ensure KUBECONFIG/context)';"
  "NS=#{ns}; #{preflight} kubectl create ns \"$NS\" >/dev/null 2>&1 || true; ( #{modified} ); rc=$?; kubectl delete ns \"$NS\" --wait=false >/dev/null 2>&1; exit $rc"
end
