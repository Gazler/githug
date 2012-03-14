require 'yaml'
module Githug
  class Profile
    PROFILE_FILE = ".profile.yml"

    attr_accessor :settings

    class << self
      def load
        settings = {
          :level => 0
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


  end
end
