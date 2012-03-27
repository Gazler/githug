require 'thor'
require 'githug'
module Githug
  class CLI < Thor


    default_task :play

    desc :play, I18n.t("githug.cli.tasks.play")

    def play
      UI.word_box("Githug")
      make_directory
      game = Game.new
      game.play_level
    end

    desc :test, I18n.t("githug.cli.tasks.test")
    method_option :errors, :type => :boolean, :default => false

    def test(path)
      UI.word_box("Githug")
      make_directory
      level = Level.load_from_file(path)  
      game = Game.new
      game.test_level(level, options[:errors])
    end

    desc :hint, I18n.t("githug.cli.tasks.hint")

    def hint
      if level = load_level
        level.show_hint
      end
    end

    desc :reset, I18n.t("githug.cli.tasks.reset")

    def reset(path = nil)
      if path
        level = Level.load_from_file(path)
      else
        level = load_level
      end
      UI.word_box("Githug")
      if level
        UI.puts I18n.t("githug.cli.reset.resetting")
        level.setup_level
        level.full_description
      else
        UI.error I18n.t("githug.cli.reset.does_not_exist")
      end
    end

    no_tasks do

      def load_level
        profile = Profile.load
        Level.load(profile.level)
      end


      def make_directory
        if File.exists?("./git_hug") 
          UI.puts I18n.t("githug.cli.make_directory.change_dir")
          exit
        end

        unless File.basename(Dir.pwd) == "git_hug"
          if UI.ask I18n.t("githug.cli.make_directory.no_dir_found")
            Dir.mkdir("./git_hug")
            Dir.chdir("git_hug")
            File.open(".gitignore", "w") do |file|
              file.write(".profile.yml")
            end
          else
            UI.puts I18n.t("githug.cli.make_directory.exiting")
            exit
          end
        end
      end

    end

  end
end
