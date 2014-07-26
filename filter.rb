require 'dante'
require 'thin'

require File.expand_path("../filter_app.rb", __FILE__)

module FileFilter
  def self.start
    Dante::Runner.new('filter').execute(
      :daemonize => true,
      :pid_path => 'tmp/filter.pid',
      :log_path => 'tmp/filter.log'
    ) do
      Thin::Server.start('localhost', '8888', FileFilterApp)
    end
  end

  def self.stop
    Dante::Runner.new('filter').execute(
      :kill => true,
      :pid_path => 'tmp/filter.pid'
    )
  end
end
