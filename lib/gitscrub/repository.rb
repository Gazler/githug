module Gitscrub
  class Repository

    attr_accessor :grit
  
    def initialize
      @grit = Grit::Repo.new(".")
    rescue Grit::InvalidGitRepositoryError
      @grit = nil
    end

    def reset
      dont_delete = ["..", ".", ".gitignore", ".profile.yml"]
      if File.basename(Dir.pwd) == "git_scrub"
        Dir.entries(Dir.pwd).each do |file|
          FileUtils.rm_rf(file) unless dont_delete.include?(file) 
        end
      end
    end


  end
end
