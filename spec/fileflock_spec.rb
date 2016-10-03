require 'spec_helper'

require 'fileflock'
require 'timeout'

RSpec.describe Fileflock do
  context 'basic usage' do
    let(:lockname) { "#{Dir.pwd}-#{rand}.lock" }

    it 'creates file with exact path provided' do
      Fileflock lockname do; end

      expect(File.exist?(lockname)).to eq(true)
    end

    it 'executes code within the lock block' do
      result = 0

      Fileflock lockname do
        result += 5
      end

      expect(result).to eq(5)
    end

    it 'raises error when lock cannot be acquired' do
      Dir.mktmpdir do |dir|
        lockname = File.join(dir, 'sample.lock')

        pid = fork do
          Fileflock lockname do
            sleep 5
          end
        end

        sleep 1

        expect {
          Fileflock lockname  do
            puts "Trying to lock this file again."
          end
        }.to raise_error(LockTimeoutReached)

        Process.wait
      end
    end

    it 'should unblock files when killing processes' do
      Dir.mktmpdir do |dir|
        lockname = File.join(dir, 'sample.lock')

        pid = fork do
          Fileflock lockname do
            sleep 5
          end
        end

        sleep 1

        expect {
          Fileflock lockname  do
            puts "Trying to lock this file again."
          end
        }.to raise_error(LockTimeoutReached)

        Process.kill(9, pid)

        expect {
          Fileflock lockname  do
            puts "Trying to lock this file again."
          end
        }.not_to raise_error(LockTimeoutReached)
      end
    end
  end
end

