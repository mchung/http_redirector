require 'rubygems'
require 'bundler'
Bundler.require(:default)
require 'rack/rewrite'


use Rack::Rewrite do
  rewrite '/batman', '/bruce-wayne.html'
  r301 'superman', '/clark-kent'
  r301 %r{/wiki/(\w+)_\w+}, '/$1'
  r302 '/marc', 'http://marcchung.com'

  # How to rewrite base on host name
  r302 '/', 'http://bing.com', :host => "bing.yiwen.org"
  r302 '/', 'http://google.com', :host => "google.yiwen.org"
  r302 '/', 'http://blekko.com', :if => Proc.new {|rack_env|
    rack_env['SERVER_NAME'] == 'blekko.yiwen.org'
  }
end

run Rack::Directory.new('public')
use Rack::Static, :root => "public", :urls => %w[/], :index => "index.html"
