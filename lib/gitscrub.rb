require "gitscrub/version"

require 'gitscrub/ui'
require 'gitscrub/game'

Gitscrub::UI.in_stream = STDIN
Gitscrub::UI.out_stream = STDOUT
