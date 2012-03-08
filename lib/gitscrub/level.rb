module Gitscrub
  class Level
    include UI

    LEVELS = [nil, "init", "add", "commit", "contribute"]

    attr_accessor :level_no
    
    class << self
      
      def load(level_no)
        level = new
        location = "#{File.dirname(__FILE__)}/../../levels/#{LEVELS[level_no]}.rb"
        return false unless File.exists?(location)
        level.instance_eval(File.read(location))
        level.level_no = level_no
        level
      end

    end

    def difficulty(num)
      @difficulty = num
    end

    def description(description)
      @description = description
    end

    def solution(&block)
      @solution = block
    end

    def setup(&block)
      @setup = block 
    end

    def full_description
      UI.puts
      UI.puts "Level: #{level_no}"
      UI.puts "Difficulty: #{"*"*@difficulty}"
      UI.puts
      UI.puts @description
      UI.puts
    end

    def setup_level
      repo.reset
      @setup.call if @setup
    end

    def repo
      @repo ||= Repository.new
    end

    def solve
      @solution.call
    rescue
      false
    end

    def hint(&hint)
      @hint = hint
    end

    def show_hint
      UI.word_box("Gitscrub")
      if @hint
        @hint.call
      else
        UI.puts("No hints available for this level")
      end
    end

  end
end
