module Gitscrub
  class Repository

    attr_accessor :grit
  
    def initialize
      @grit = Grit::Repo.new(".")
    rescue Grit::InvalidGitRepositoryError
      @grit = nil
    end


  end
end
