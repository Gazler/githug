require 'yaml'
module Githug
  class Profile
    PROFILE_FILE = ".profile.yml"

    attr_accessor :settings

    class << self
      def load
        self.new(settings)
      end

      private

      def settings
        return defaults unless File.exists?(PROFILE_FILE)
        defaults.merge(YAML::load(File.open(PROFILE_FILE)))
      end

      def defaults
        {
          :level => nil,
          :current_attempts => 0,
          :current_hint_index => 0,
          :current_levels => [],
          :completed_levels => []
        }
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

    def set_level(name)
      settings[:level] = name
      reset!
      save
    end

    def level_bump
      settings[:completed_levels] << level
      settings[:current_levels] = levels
      set_level(next_level)
    end

    private

    def levels
      Level::LEVELS
    end

    def next_level
      (levels - settings[:completed_levels]).first || levels.last
    end

    def reset!
      settings[:current_attempts] = 0
      settings[:current_hint_index] = 0
    end

  end
end
