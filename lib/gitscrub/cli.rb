require 'thor'
require 'gitscrub'
module Gitscrub
  class CLI < Thor

    desc :setup, "a"
    default_task :setup

    def setup
      UI.word_box("Gitscrub")

      unless File.exists?("./git_scrub") 
        if UI.ask("No gitscrubber directory found, do you wish to create one?")
          Dir.mkdir("./git_scrub")
        else
          UI.puts("Exiting")
        end
      end
    end

  end
end
