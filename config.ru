require 'rubygems'
require 'bundler'
Bundler.require(:default)
require 'pp'
require 'rack/rewrite'

use Rack::Reloader
use Rack::Rewrite do
  rewrite '/wiki/John_Trupiano', '/nuts'
  r301 '/wiki/Yair_Flicker', '/yair'
  r302 '/wiki/Greg_Jastrab', '/greg'
  r301 %r{/wiki/(\w+)_\w+}, '/$1'
  r302 '/marc', 'http://marcchung.com/blog'
  r302 '/super', 'http://marcchung.com'

  # How to rewrite base on host name
  r302 '/', 'http://bing.com', :host => "bing.yiwen.org"
  r302 '/', 'http://google.com', :host => "google.yiwen.org"
  r302 '/', 'http://blekko.com', :if => Proc.new {|rack_env|
    rack_env['SERVER_NAME'] == 'blekko.yiwen.org'
  }
end

run Rack::Directory.new('public')