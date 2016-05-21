require 'thor'
require 'githug'

module Githug
  class CLI < Thor
    default_task :play

    desc :play, "Zacznij gre!"

    def play
      UI.word_box("Testing Cup 2016 GIT training (based on Githug)")
      make_directory!
      Game.new.play_level
    end

    desc :test, "Sprawdz zadanie z podanej sciezki."
    method_option :errors, :type => :boolean, :default => false

    def test(path)
      UI.word_box("Testing Cup 2016 GIT training (based on Githug)")
      make_directory!
      level = Level.load_from_file(path)
      Game.new.test_level(level, options[:errors])
    end

    desc :hint, "Wypisz wskazowki dla aktualnego zadania."

    def hint
      if level = load_level
        level.show_hint
      end
    end

    desc :reset, "Wyczysc stan obecnego poziomu."

    def reset(path = nil)
      level = load_level(path)
      UI.word_box("Testing Cup 2016 GIT training (based on Githug)")
      if level
        UI.puts("czyszczenie poziomu")
        level.setup_level
        level.full_description
      else
        UI.error("Poziom nie istnieje")
      end
    end

    desc :levels, "Pokaz wszystkie poziomy."

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
          UI.puts "Wejdz do katalogu git_hug"
          exit
        end
      end

      def prompt_githug_directory!
        unless UI.ask("Nie znaleziono katalogu git_hug. Czy stworzyc nowy?")
          UI.puts("Wychodze")
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
