require 'rubygems'
require 'gollum/frontend/app'

class Auth
  def initialize(app)
    @app = app
  end

  # Sets Gollum author to match the authenticated user passed by
  # wwwhisper in the 'User' header.
  def call(env)
    if env.has_key?('HTTP_USER')
      gollum_author = { :name => env['HTTP_USER'], :email => env['HTTP_USER'] }
    else
      gollum_author = { :name => 'anonymous', :email => 'unknown@example.com' }
    end
    env['rack.session'] = { 'gollum.author' => gollum_author }
    @app.call(env)
  end
end

set :run, false
set :environment, :production
#Precious::App.set(:wiki_options, {:base_path => "/wiki"})
Precious::App.set(:wiki_options, {})
Precious::App.set(:gollum_path, ENV["OPENSHIFT_DATA_DIR"] + "wiki/")
# Set your favorite markup language
Precious::App.set(:default_markup, :markdown)

log = File.new(ENV["OPENSHIFT_LOG_DIR"] + "gollum.log", "a+")
$stdout.reopen(log)
$stderr.reopen(log)

use Auth

# Serve from /wiki path
map '/wiki' do
    run Precious::App
end

