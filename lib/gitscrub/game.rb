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
        profile.level = 1
        profile.save
        solve = false
      else
        level = Level.load(profile.level)
        if solve
          if level.solve  
            UI.puts "Congratulations, you have solved the level"
          else
            UI.puts "Sorry, this solution is not quite right!"
          end
        end
      end
    end

  end
end
