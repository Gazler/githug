require 'grit'

require "githug/extensions/grit/ruby1.9"

ee
require "githug/version"

require 'githug/ui'
require 'githug/game'
require 'githug/profile'
require 'githug/level'
require 'githug/repository'

Githug::UI.in_stream = STDINR
Githug::UI.out_stream = STDOUT
STDIN.sync = true
