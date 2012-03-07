module Gitscrub
  class Game

    attr_accessor :profile

    def initialize
      @profile = Profile.load
    end

    def play_level
      solve = true
      if profile.level == 0
        UI.puts("Welcome to Gitscrub")
        solve = false
        level_bump
      else
        level = Level.load(profile.level)
        if solve && level
          if level.solve  
            UI.puts "Congratulations, you have solved the level"
            level_bump
          else
            UI.puts "Sorry, this solution is not quite right!"
            UI.puts
            UI.puts level.ldescription
            UI.puts
          end
        end
      end
    end

    def level_bump
      profile.level += 1
      profile.save
      if level = Level.load(profile.level)
        UI.puts
        UI.puts(level.ldescription)
        UI.puts
      end
    end

  end
end
