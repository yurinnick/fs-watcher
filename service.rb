# Encoding: utf-8

require File.expand_path("../watcher.rb", __FILE__)
require File.expand_path("../filter.rb", __FILE__)

case ARGV[0]
when 'start'
  puts "Watcher gonna watch"
  FileWatcher::start
  FileFilter::start
when 'stop'
  puts 'Watcher stoped!'
  FileWatcher::stop
  FileFilter::stop
end
