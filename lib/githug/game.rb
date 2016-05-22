module Githug
  class Game

    attr_accessor :profile

    def initialize
      @profile = Profile.load
    end

    def play_level
      solve = true
      if profile.level.nil?
        UI.puts("Witamy w Githug!")
        solve = false
        level_bump
      else
        level = Level.load(profile.level)
        if solve && level
          if level.solve
            UI.success "Dobra robota, rozwiazany poziom!"
            level_bump
          else
            UI.error "Niestety, rozwiazanie nie jest do konca poprawne!"
            profile.current_attempts += 1
            profile.save

            if (profile.current_attempts > 2 && profile.current_attempts % 3 == 0)
              UI.error "Nie zapomnij, ze mozesz znalezc wskazowki za pomoca `githug hint` i wystartowac od poczatku za pomoca `githug reset`."
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
        UI.success "Poprawne rozwiazanie"
      else
        UI.error "Niepoprawne rozwiazanie"
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
