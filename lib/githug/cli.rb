require 'thor'
require 'githug'
module Githug
  class CLI < Thor


    default_task :play

    desc :play, "Initialize the game"

    def play
      UI.word_box("Githug")
      make_directory!
      Game.new.play_level
    end

    desc :test, "Test a level from a file path"
    method_option :errors, :type => :boolean, :default => false

    def test(path)
      UI.word_box("Githug")
      make_directory!
      level = Level.load_from_file(path)
      Game.new.test_level(level, options[:errors])
    end

    desc :hint, "Get a hint for the current level"

    def hint
      if level = load_level
        level.show_hint
      end
    end

    desc :reset, "Reset the current level"
    long_desc <<-LONGDESC
      `githug reset` will reset the current level. You can optionally specify a
      LEVEL parameter which will reset the game to a specific level. For
      example:

      > $ githug reset merge_squash

      Will reset githug to level '#45: merge_squash'
    LONGDESC
    def reset(path = nil)
      level = load_level(path)
      UI.word_box("Githug")
      if level
        UI.puts("resetting level")
        level.setup_level
        level.full_description
      else
        UI.error("Level does not exist")
      end
    end

    desc :levels, "List all of the levels"

    def levels
      list_with_numbers = Level.list.each_with_index.map do |name, index|
        "##{index + 1}: #{name}"
      end
      UI.puts(list_with_numbers)
    end

    no_tasks do

      def load_level(path = nil)
        return load_level_from_profile unless path
        return load_level_from_name(path) if Level.list.include?(path)
        Level.load_from_file(path)
      end

      def load_level_from_name(name)
        profile = Profile.load
        profile.set_level(name)
        Level.load(name)
      end

      def load_level_from_profile
        profile = Profile.load
        Level.load(profile.level)
      end


      def make_directory!
        return if File.basename(Dir.pwd) == "git_hug"
        check_githug_directory!
        prompt_githug_directory!
        make_githug_directory!
      end

      def check_githug_directory!
        if File.exists?("./git_hug")
          UI.puts "Please change into the git_hug directory"
          exit
        end
      end

      def prompt_githug_directory!
        unless UI.ask("No githug directory found, do you wish to create one?")
          UI.puts("Exiting")
          exit
        end
      end

      def make_githug_directory!
        Dir.mkdir("./git_hug")
        Dir.chdir("git_hug")
      end

    end

  end
end
