# Encoding: utf-8

require 'sinatra'
require 'json'
require 'fileutils'

class FileFilterApp < Sinatra::Base
  configure do
    set :threaded, true
  end

  get "/:sec" do
    content_type :json
    file_list = Dir.glob('/home/**/*').reject { |path| File.directory? path }
    .select { |path| File.ctime(path) > (Time.now - params[:sec].to_i) }

    median =  if file_list.empty?
                0
              else
                sorted = file_list.map { |f| File.basename(f).length }.sort
                len = sorted.length
                (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0
              end
    return { "files" => file_list, "median_length" => median }.to_json
  end
end
