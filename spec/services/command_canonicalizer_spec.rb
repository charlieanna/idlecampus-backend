require 'rails_helper'

RSpec.describe CommandCanonicalizer do
  let(:canonicalizer) { described_class.new }

  describe '#canonicalize' do
    context 'Docker commands' do
      it 'canonicalizes docker run variations' do
        expect(canonicalizer.canonicalize('docker run nginx')).to eq('docker_run')
        expect(canonicalizer.canonicalize('docker container run nginx')).to eq('docker_run')
        expect(canonicalizer.canonicalize('docker run -d nginx')).to eq('docker_run')
        expect(canonicalizer.canonicalize('docker run -p 8080:80 nginx')).to eq('docker_run')
      end

      it 'canonicalizes docker ps variations' do
        expect(canonicalizer.canonicalize('docker ps')).to eq('docker_ps')
        expect(canonicalizer.canonicalize('docker ps -a')).to eq('docker_ps')
        expect(canonicalizer.canonicalize('docker container ls')).to eq('docker_ps')
        expect(canonicalizer.canonicalize('docker container list')).to eq('docker_ps')
      end

      it 'canonicalizes docker stop variations' do
        expect(canonicalizer.canonicalize('docker stop container123')).to eq('docker_stop')
        expect(canonicalizer.canonicalize('docker container stop myapp')).to eq('docker_stop')
        expect(canonicalizer.canonicalize('docker stop --time=10 app')).to eq('docker_stop')
      end

      it 'canonicalizes docker build variations' do
        expect(canonicalizer.canonicalize('docker build .')).to eq('docker_build')
        expect(canonicalizer.canonicalize('docker build -t myimage:tag .')).to eq('docker_build')
        expect(canonicalizer.canonicalize('docker image build --tag app .')).to eq('docker_build')
      end

      it 'canonicalizes docker pull variations' do
        expect(canonicalizer.canonicalize('docker pull nginx')).to eq('docker_pull')
        expect(canonicalizer.canonicalize('docker image pull nginx:latest')).to eq('docker_pull')
        expect(canonicalizer.canonicalize('docker pull registry.com/image')).to eq('docker_pull')
      end

      it 'canonicalizes docker exec variations' do
        expect(canonicalizer.canonicalize('docker exec -it container bash')).to eq('docker_exec')
        expect(canonicalizer.canonicalize('docker container exec myapp ls')).to eq('docker_exec')
        expect(canonicalizer.canonicalize('docker exec container command')).to eq('docker_exec')
      end

      it 'canonicalizes docker-compose commands' do
        expect(canonicalizer.canonicalize('docker-compose up')).to eq('docker_compose_up')
        expect(canonicalizer.canonicalize('docker compose up -d')).to eq('docker_compose_up')
        expect(canonicalizer.canonicalize('docker-compose down')).to eq('docker_compose_down')
      end
    end

    context 'Kubernetes commands' do
      it 'canonicalizes kubectl get variations' do
        expect(canonicalizer.canonicalize('kubectl get pods')).to eq('kubectl_get_pods')
        expect(canonicalizer.canonicalize('kubectl get pod')).to eq('kubectl_get_pods')
        expect(canonicalizer.canonicalize('kubectl get po')).to eq('kubectl_get_pods')
        expect(canonicalizer.canonicalize('kubectl get pods -n namespace')).to eq('kubectl_get_pods')
      end

      it 'canonicalizes kubectl apply variations' do
        expect(canonicalizer.canonicalize('kubectl apply -f file.yaml')).to eq('kubectl_apply')
        expect(canonicalizer.canonicalize('kubectl apply -f directory/')).to eq('kubectl_apply')
        expect(canonicalizer.canonicalize('kubectl apply --filename=manifest.yml')).to eq('kubectl_apply')
      end

      it 'canonicalizes kubectl describe variations' do
        expect(canonicalizer.canonicalize('kubectl describe pod mypod')).to eq('kubectl_describe_pod')
        expect(canonicalizer.canonicalize('kubectl describe pods/mypod')).to eq('kubectl_describe_pod')
        expect(canonicalizer.canonicalize('kubectl describe deployment myapp')).to eq('kubectl_describe_deployment')
        expect(canonicalizer.canonicalize('kubectl describe svc myservice')).to eq('kubectl_describe_service')
      end

      it 'canonicalizes kubectl delete variations' do
        expect(canonicalizer.canonicalize('kubectl delete pod mypod')).to eq('kubectl_delete')
        expect(canonicalizer.canonicalize('kubectl delete -f file.yaml')).to eq('kubectl_delete')
        expect(canonicalizer.canonicalize('kubectl delete deployment myapp')).to eq('kubectl_delete')
      end
    end

    context 'edge cases' do
      it 'handles nil input' do
        expect(canonicalizer.canonicalize(nil)).to be_nil
      end

      it 'handles empty string' do
        expect(canonicalizer.canonicalize('')).to be_nil
      end

      it 'handles unrecognized commands' do
        expect(canonicalizer.canonicalize('unknown command')).to be_nil
      end

      it 'handles commands with extra whitespace' do
        expect(canonicalizer.canonicalize('  docker   run   nginx  ')).to eq('docker_run')
      end

      it 'handles commands with newlines' do
        expect(canonicalizer.canonicalize("docker run \\\n  -p 8080:80 \\\n  nginx")).to eq('docker_run')
      end
    end
  end

  describe '#extract_commands' do
    it 'extracts multiple Docker commands from text' do
      text = <<~TEXT
        First, run `docker pull nginx` to get the image.
        Then use `docker run -d nginx` to start the container.
        Finally, check with `docker ps` to see it running.
      TEXT
      
      commands = canonicalizer.extract_commands(text)
      expect(commands).to contain_exactly('docker_pull', 'docker_run', 'docker_ps')
    end

    it 'extracts Kubernetes commands from text' do
      text = <<~TEXT
        Deploy with: kubectl apply -f deployment.yaml
        Check status: kubectl get pods
        Debug issues: kubectl describe pod mypod
      TEXT
      
      commands = canonicalizer.extract_commands(text)
      expect(commands).to contain_exactly('kubectl_apply', 'kubectl_get_pods', 'kubectl_describe_pod')
    end

    it 'handles text with no commands' do
      text = "This is just regular text without any commands."
      commands = canonicalizer.extract_commands(text)
      expect(commands).to be_empty
    end

    it 'deduplicates extracted commands' do
      text = <<~TEXT
        Run docker ps to list containers.
        Use docker ps -a to see all containers.
        docker ps shows running containers.
      TEXT
      
      commands = canonicalizer.extract_commands(text)
      expect(commands).to eq(['docker_ps'])
    end
  end
end