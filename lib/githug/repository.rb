module Githug
  class Repository

    attr_accessor :grit
  
    def initialize(location = ".")
      @grit = Grit::Repo.new(location)
    rescue Grit::InvalidGitRepositoryError
      @grit = nil
    end

    def reset
      dont_delete = ["..", ".", ".gitignore", ".profile.yml"]
      if File.basename(Dir.pwd) == "git_hug"
        Dir.entries(Dir.pwd).each do |file|
          FileUtils.rm_rf(file) unless dont_delete.include?(file) 
        end
      end
    end

    def valid?
      !@grit.nil?
    end

    def init(*args)
      @grit = Grit::Repo.init(".")
    end

    def method_missing(method, *args, &block)
      if @grit && @grit.respond_to?(method) 
        return @grit.send(method, *args, &block)
      end
      super
    end


  end
end
