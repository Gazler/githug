module Githug
  class Game

    attr_accessor :profile

    def initialize
      @profile = Profile.load
    end

    def play_level
      solve = true
      if profile.level.nil?
        UI.puts("Welcome to Githug!")
        solve = false
        level_bump
      else
        level = Level.load(profile.level)
        if solve && level
          if level.solve
            UI.success "Congratulations, you have solved the level!"
            level_bump
          else
            UI.error "Sorry, this solution is not quite right!"
            profile.current_attempts += 1
            profile.save

            if (profile.current_attempts > 2 && profile.current_attempts % 3 == 0)
              UI.error "Don't forget you can type `githug hint` for a hint and `githug reset` to reset the current level."
            end

            UI.puts level.full_description
          end
        end
      end
    end

    def test_level(level, errors = nil)
      UI.puts level.full_description
      method = :solve
      method = :test if errors
      if level.send(method)
        UI.success "Valid solution"
      else
        UI.error "Invalid solution"
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
