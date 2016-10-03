require "fileflock/version"
require "timeout"

LOCK_PATH = "#{Dir.pwd}"

class LockTimeoutReached < StandardError; end

define_method(:Fileflock) do |lockname, lockpath: LOCK_PATH, &block|
  FileUtils.mkdir_p(lockpath) unless File.exist?(lockpath)

  File.open(lockname, File::RDWR|File::CREAT, 0644) do |file|
    begin
      Timeout::timeout(0.01) { file.flock(File::LOCK_EX) }
    rescue Timeout::Error
      raise LockTimeoutReached
    end
    block.call
  end
end

