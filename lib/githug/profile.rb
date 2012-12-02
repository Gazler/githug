require 'yaml'
module Githug
  class Profile
    PROFILE_FILE = ".profile.yml"

    attr_accessor :settings

    class << self
      def load
        settings = {
          :level => nil,
          :current_attempts => 0,
          :current_hint_index => 0,
          :current_levels => [],
          :completed_levels => []
        }

        settings.merge! YAML::load(File.open(PROFILE_FILE)) if File.exists?(PROFILE_FILE)

        self.new(settings)
      end
    end


    def method_missing(method, *args, &block)
      if method.to_s.end_with?("=")
        method = method.to_s.chop.to_sym
        return settings[method] = args[0] if settings.include?(method)
      end
      return(settings[method]) if settings.include?(method)
      super
    end

    def initialize(settings)
      @settings = settings
    end

    def save
      File.open(PROFILE_FILE, 'w') do |out|
        YAML.dump(settings, out)
      end
    end

    def level_bump
      levels = Level::LEVELS
      level_no = levels.index(settings[:level])

      settings[:completed_levels] << level

      settings[:current_levels] = levels

      settings[:current_attempts] = 0

      settings[:current_hint_index] = 0

      next_level = (levels - settings[:completed_levels]).first || levels.last

      settings[:level] = next_level
      save
      next_level
    end


  end
end
