require 'rubygems'
require 'bundler/setup'

require 'active_support/all'
require 'redis'

ActiveSupport::Dependencies.autoload_paths << File.expand_path('../../lib', __FILE__)
