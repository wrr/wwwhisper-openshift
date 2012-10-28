require 'rubygems'
require 'gollum/frontend/app'

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

# Serve from /wiki path
map '/wiki' do
    run Precious::App
end

