require 'grit'

require "githug/extensions/grit/ruby1.9"


require "githug/version"

require 'githug/ui'
require 'githug/game'
require 'githug/profile'
require 'githug/level'
require 'githug/repository'

Githug::UI.in_stream = STDIN
Githug::UI.out_stream = STDOUT
