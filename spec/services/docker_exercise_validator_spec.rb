require 'rails_helper'

RSpec.describe DockerExerciseValidator do
  describe '.validate' do
    context 'basic validation' do
      it 'rejects empty commands' do
        result = described_class.validate('', {})
        expect(result[:valid]).to be false
        expect(result[:message]).to eq('Please enter a command.')
      end

      it 'rejects whitespace-only commands' do
        result = described_class.validate('   ', {})
        expect(result[:valid]).to be false
        expect(result[:message]).to eq('Please enter a command.')
      end
    end

    context 'docker run command validation' do
      it 'validates basic docker run' do
        spec = { base_command: 'docker run', accepts_any_image: true }
        result = described_class.validate('docker run nginx', spec)
        expect(result[:valid]).to be true
      end

      it 'validates docker run with -d flag' do
        spec = { base_command: 'docker run', required_flags: ['-d'], accepts_any_image: true }
        result = described_class.validate('docker run -d nginx', spec)
        expect(result[:valid]).to be true
      end

      it 'validates docker run with --name flag' do
        spec = { base_command: 'docker run', required_flags: ['--name myapp'], accepts_any_image: true }
        result = described_class.validate('docker run --name myapp nginx', spec)
        expect(result[:valid]).to be true
      end

      it 'validates docker run with combined flags' do
        spec = { base_command: 'docker run', required_flags: ['-d', '--name myapp'], accepts_any_image: true }
        result = described_class.validate('docker run -d --name myapp nginx', spec)
        expect(result[:valid]).to be true
      end

      it 'rejects missing required flag' do
        spec = { base_command: 'docker run', required_flags: ['-d'], accepts_any_image: true }
        result = described_class.validate('docker run nginx', spec)
        expect(result[:valid]).to be false
        expect(result[:message]).to include('Missing required flag')
      end

      it 'validates specific image requirement' do
        spec = { base_command: 'docker run', required_image: 'nginx' }
        result = described_class.validate('docker run nginx', spec)
        expect(result[:valid]).to be true
      end

      it 'rejects wrong image' do
        spec = { base_command: 'docker run', required_image: 'nginx' }
        result = described_class.validate('docker run apache', spec)
        expect(result[:valid]).to be false
        expect(result[:message]).to include('Use image: nginx')
      end

      it 'validates image with tag' do
        spec = { base_command: 'docker run', required_image: 'nginx', required_tag: 'alpine' }
        result = described_class.validate('docker run nginx:alpine', spec)
        expect(result[:valid]).to be true
      end

      it 'rejects wrong tag' do
        spec = { base_command: 'docker run', required_tag: 'alpine' }
        result = described_class.validate('docker run nginx:latest', spec)
        expect(result[:valid]).to be false
        expect(result[:message]).to include('Use tag: alpine')
      end
    end

    context 'docker ps command validation' do
      it 'validates basic docker ps' do
        spec = { base_command: 'docker ps' }
        result = described_class.validate('docker ps', spec)
        expect(result[:valid]).to be true
      end

      it 'validates docker ps -a' do
        spec = { base_command: 'docker ps', required_flags: ['-a'] }
        result = described_class.validate('docker ps -a', spec)
        expect(result[:valid]).to be true
      end

      it 'rejects docker ps when -a is required' do
        spec = { base_command: 'docker ps', required_flags: ['-a'] }
        result = described_class.validate('docker ps', spec)
        expect(result[:valid]).to be false
      end
    end

    context 'docker logs command validation' do
      it 'validates docker logs with container name' do
        spec = { base_command: 'docker logs', requires_argument: true }
        result = described_class.validate('docker logs myapp', spec)
        expect(result[:valid]).to be true
      end

      it 'validates docker logs -f' do
        spec = { base_command: 'docker logs', required_flags: ['-f'], requires_argument: true }
        result = described_class.validate('docker logs -f myapp', spec)
        expect(result[:valid]).to be true
      end

      it 'rejects docker logs without container name' do
        spec = { base_command: 'docker logs', requires_argument: true }
        result = described_class.validate('docker logs', spec)
        expect(result[:valid]).to be false
      end
    end

    context 'docker exec command validation' do
      it 'validates docker exec -it with bash' do
        spec = { base_command: 'docker exec', required_flags: ['-it'], requires_argument: true }
        result = described_class.validate('docker exec -it myapp bash', spec)
        expect(result[:valid]).to be true
      end

      it 'validates docker exec without flags' do
        spec = { base_command: 'docker exec', requires_argument: true }
        result = described_class.validate('docker exec myapp ls', spec)
        expect(result[:valid]).to be true
      end
    end

    context 'docker build command validation' do
      it 'validates docker build with tag' do
        spec = { base_command: 'docker build', required_flags: ['-t'] }
        result = described_class.validate('docker build -t myapp:v1 .', spec)
        expect(result[:valid]).to be true
      end

      it 'validates docker build with --no-cache' do
        spec = { base_command: 'docker build', required_flags: ['--no-cache'] }
        result = described_class.validate('docker build --no-cache -t myapp .', spec)
        expect(result[:valid]).to be true
      end
    end

    context 'docker network command validation' do
      it 'validates docker network create' do
        spec = { base_command: 'docker network create' }
        result = described_class.validate('docker network create myapp-net', spec)
        expect(result[:valid]).to be true
      end
    end

    context 'docker volume command validation' do
      it 'validates docker volume create' do
        spec = { base_command: 'docker volume create' }
        result = described_class.validate('docker volume create myapp-data', spec)
        expect(result[:valid]).to be true
      end
    end

    context 'require_success validation' do
      it 'passes when command succeeds' do
        spec = { base_command: 'docker ps', require_success: true }
        result_hash = { success: true, output: 'CONTAINER ID   IMAGE   ...' }
        validation = described_class.validate('docker ps', result_hash, spec)
        expect(validation[:valid]).to be true
      end

      it 'fails when command fails with helpful error' do
        spec = { base_command: 'docker run', require_success: true, accepts_any_image: true }
        result_hash = { success: false, output: 'Error: No such image: nginx123' }
        validation = described_class.validate('docker run nginx123', result_hash, spec)
        expect(validation[:valid]).to be false
        expect(validation[:message]).to include("doesn't exist")
      end

      it 'provides helpful error for container name conflict' do
        spec = { base_command: 'docker run', require_success: true, accepts_any_image: true }
        result_hash = { success: false, output: 'Error: Conflict. The container name "/myapp" is already in use' }
        validation = described_class.validate('docker run --name myapp nginx', result_hash, spec)
        expect(validation[:valid]).to be false
        expect(validation[:message]).to include('already exists')
        expect(validation[:message]).to include('docker rm -f myapp')
      end
    end

    context 'alternative command formats' do
      it 'accepts docker container run' do
        spec = { base_command: ['docker run', 'docker container run'], accepts_any_image: true }
        result = described_class.validate('docker container run nginx', spec)
        expect(result[:valid]).to be true
      end
    end

    context 'story-aware messages' do
      it 'provides contextual message for myapp deployment' do
        result = described_class.validate('docker run -d --name myapp nginx', {})
        expect(result[:message]).to include('MyApp')
      end

      it 'provides contextual message for docker logs' do
        result = described_class.validate('docker logs -f myapp', {})
        expect(result[:message]).to include('Streaming')
      end
    end
  end
end