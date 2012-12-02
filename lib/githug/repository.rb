module Githug
  class Repository

    attr_accessor :grit

    def initialize(location = ".")
      @grit = Grit::Repo.new(location)
    rescue Grit::InvalidGitRepositoryError
      @grit = nil
    end

    def reset
      dont_delete = ["..", ".", ".profile.yml"]
      if File.basename(Dir.pwd) == "git_hug"
        Dir.entries(Dir.pwd).each do |file|
          FileUtils.rm_rf(file) unless dont_delete.include?(file)
        end
      end
      create_gitignore
    end

    def create_gitignore
      Dir.chdir("git_hug") if File.exists?("./git_hug")
      File.open(".gitignore", "w") do |file|
        file.puts(".profile.yml")
        file.puts(".gitignore")
      end
    end

    def valid?
      !@grit.nil?
    end

    # Initialize a Git repo. If the repo already exists, do nothing.
    def init(location = ".")
      @grit = Grit::Repo.init(location)
    end

    def method_missing(method, *args, &block)
      if @grit && @grit.respond_to?(method)
        return @grit.send(method, *args, &block)
      end
      super
    end


  end
end
