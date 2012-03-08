require 'spec_helper'

describe Gitscrub::Repository do
    
  before(:each) do
    @grit = mock
    Grit::Repo.stub(:new).and_return(@grit) 
    @repository = Gitscrub::Repository.new
  end

  describe "initialize" do
    
    it "should call grit on initialize" do
      Grit::Repo.should_receive(:new).and_return(@grit) 
      repo = Gitscrub::Repository.new
      repo.grit.should equal(@grit)
    end

    it "should contain a nil grit if the repo is invalid" do
      Grit::Repo.should_receive(:new).and_raise(Grit::InvalidGitRepositoryError) 
      repo = Gitscrub::Repository.new
      repo.grit.should equal(nil)
    end

  end

  describe "reset" do

    before(:each) do
      FileUtils.stub(:rm_rf) 
    end

    it "should do nothing if the current directory isn't git_scrub" do
      Dir.stub(:pwd).and_return("/tmp/foo")
      FileUtils.should_not_receive(:rm_rf)
      @repository.reset
    end
    
    it "should remove all the files except .gitignore and .profile.yml" do
      Dir.stub(:pwd).and_return("/tmp/git_scrub")
      Dir.stub(:entries).and_return([".profile.yml", ".gitignore", "..", ".", "README", ".git"])
      FileUtils.should_receive(:rm_rf).with("README")
      FileUtils.should_receive(:rm_rf).with(".git")
      @repository.reset
    end
  end

  describe "valid?" do
    it "should be valid if grit exists" do
      @repository.should be_valid  
    end

    it "should not be valid if grit does not exist" do
      @repository.instance_variable_set("@grit", nil) 
      @repository.should_not be_valid
    end
  end


end
