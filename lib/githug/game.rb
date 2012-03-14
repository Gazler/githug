module Githug
  class Game

    attr_accessor :profile

    def initialize
      @profile = Profile.load
    end

    def play_level
      solve = true
      if profile.level.nil?
        UI.puts("Welcome to Githug")
        solve = false
        level_bump
      else
        level = Level.load(profile.level)
        if solve && level
          if level.solve  
            UI.success "Congratulations, you have solved the level"
            level_bump
          else
            UI.error "Sorry, this solution is not quite right!"
            UI.puts level.full_description
          end
        end
      end
    end

    def level_bump
      profile.level_bump
      if level = Level.load(profile.level)
        UI.puts(level.full_description)
        level.setup_level
      end
    end

  end
end
