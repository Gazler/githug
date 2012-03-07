require 'grit'
require "gitscrub/version"

require 'gitscrub/ui'
require 'gitscrub/game'
require 'gitscrub/profile'
require 'gitscrub/level'

Gitscrub::UI.in_stream = STDIN
Gitscrub::UI.out_stream = STDOUT
