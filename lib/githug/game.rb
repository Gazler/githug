module Githug
  class Game

    attr_accessor :profile

    def initialize
      @profile = Profile.load
    end

    def play_level
      solve = true
      if profile.level.nil?
        UI.puts I18n.t("githug.game.play_level.welcome")
        solve = false
        level_bump
      else
        level = Level.load(profile.level)
        if solve && level
          if level.solve  
            UI.success I18n.t("githug.game.play_level.success")
            level_bump
          else
            UI.error I18n.t("githug.game.play_level.failure")
            profile.current_attempts += 1
            profile.save

            if (profile.current_attempts > 2 && profile.current_attempts % 3 == 0)
              UI.error I18n.t("githug.game.play_level.hint_prompt")
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
        UI.success I18n.t("githug.game.test_level.valid")
      else
        UI.error I18n.t("githug.game.test_level.invalid")
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
