require 'sinatra'


set :port, 5555
set :bind, '0.0.0.0'
set :root, File.dirname(__FILE__)

get "/" do
  File.read("treasury.out").gsub(/\n/, "<br/>")
end
