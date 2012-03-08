module Gitscrub
  class Level
    include UI

    attr_accessor :ldifficulty, :ldescription, :lsolution, :level_no, :lsetup
    
    class << self
      
      def load(level_no)
        level = new
        location = "#{File.dirname(__FILE__)}/../../levels/#{level_no}.rb"
        return false unless File.exists?(location)
        level.instance_eval(File.read(location))
        level.level_no = level_no
        level
      end

    end

    def difficulty(num)
      @ldifficulty = num
    end

    def description(description)
      @ldescription = description
    end

    def solution(&block)
      @lsolution = block
    end

    def setup(&block)
      @lsetup = block 
    end

    def full_description
      UI.puts
      UI.puts "Level: #{level_no}"
      UI.puts "Difficulty: #{"*"*ldifficulty}"
      UI.puts
      UI.puts ldescription
      UI.puts
    end

    def setup_level
      lsetup.call
    end

    def solve
      lsolution.call
    rescue
      false
    end

  end
end
