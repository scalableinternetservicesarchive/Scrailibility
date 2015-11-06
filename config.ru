# This file is used by Rack-based servers to start the application.

# require ::File.expand_path('../config/environment', __FILE__)
# run Rails.application

# config.ru
# Run with: rackup private_pub.ru -s thin -E production
require "bundler/setup"
require "yaml"
require "faye"
require "private_pub"

Faye::WebSocket.load_adapter('thin')

PrivatePub.load_config(
  File.expand_path(
    "../config/private_pub.yml", __FILE__
  ), 'production'
)
run PrivatePub.faye_app
