# Encoding: utf-8

require 'dante'
require 'listen'
require 'fileutils'
require 'thin'

module FileWatcher
  def self.start
    Dante::Runner.new('watcher').execute(
      :daemonize => true,
      :pid_path => 'tmp/watcher.pid',
      :log_path => 'tmp/watcher.log'
    ) do
      host = 'ec2-54-212-188-149.us-west-2.compute.amazonaws.com'
      log_path = '/var/log/newfiles.log'
      watch_path = '/home'

      file_watcher = Listen.to(watch_path) do |modified, added, removed|
        File.open(log_path, 'a') do |file|
          file.puts("#{added[0]}") unless added.empty?
        end
      end
      file_watcher.start
      sleep
    end
  end

  def self.stop
    Dante::Runner.new('watcher').execute(
      :kill => true,
      :pid_path => 'tmp/watcher.pid'
    )
  end
end
