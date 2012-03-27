require 'grit'
require 'i18n'
require 'patches/i18n'

require "githug/version"

require 'githug/ui'
require 'githug/game'
require 'githug/profile'
require 'githug/level'
require 'githug/repository'

root_path = "#{File.dirname(__FILE__)}/../config"
I18n.load_path = Dir["#{root_path}/*.yml"]
I18n.locale = :en 

Githug::UI.in_stream = STDIN
Githug::UI.out_stream = STDOUT
