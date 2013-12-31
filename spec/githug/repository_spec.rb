require 'spec_helper'

describe Githug::Repository do

  let(:grit) { mock }

  before(:each) do
    Grit::Repo.stub(:new).and_return(grit)
    subject.stub(:create_gitignore)
  end

  describe "#initialize" do

    it "calls grit on initialize" do
      Grit::Repo.should_receive(:new).with(".").and_return(grit)
      repo = Githug::Repository.new
      repo.grit.should equal(grit)
    end

    it "contains a nil grit if the repo is invalid" do
      Grit::Repo.should_receive(:new).and_raise(Grit::InvalidGitRepositoryError)
      repo = Githug::Repository.new
      repo.grit.should equal(nil)
    end

    it "initializes with a location" do
      Grit::Repo.should_receive(:new).with("test").and_return(grit)
      repo = Githug::Repository.new("test")
    end

  end

  describe "#reset" do

    before(:each) do
      FileUtils.stub(:rm_rf)
    end

    it "does nothing if the current directory isn't git_hug" do
      Dir.stub(:pwd).and_return("/tmp/foo")
      FileUtils.should_not_receive(:rm_rf)
      subject.reset
    end

    it "removes all the files except .gitignore and .profile.yml" do
      Dir.stub(:pwd).and_return("/tmp/git_hug")
      Dir.stub(:entries).and_return([".profile.yml", ".gitignore", "..", ".", "README", ".git"])
      FileUtils.should_receive(:rm_rf).with("README")
      FileUtils.should_receive(:rm_rf).with(".git")
      subject.reset
    end
  end


  describe "#create_gitignore" do
    it "creates a gitignore" do
      subject.unstub(:create_gitignore)
      File.stub(:exists?).and_return(true)
      Dir.should_receive(:chdir).with("git_hug")
      File.should_receive(:open).with(".gitignore", "w")
      subject.create_gitignore
    end
  end

  describe "#valid?" do
    it "is valid if grit exists" do
      subject.should be_valid
    end

    it "is not valid if grit does not exist" do
      subject.instance_variable_set("@grit", nil)
      subject.should_not be_valid
    end
  end

  describe "#init" do
    it "does not add and commit gitignore if prompted" do
      Grit::Repo.should_receive(:init).with(".")
      subject.init
    end
  end

  describe "#method_missing" do
    it "deletegates to grit if the method exists" do
      grit.should_receive(:respond_to?).with(:valid_method).and_return(true)
      grit.should_receive(:valid_method)
      subject.valid_method
    end

    it "should not deletegate to grit if the method does not exist" do
      grit.should_receive(:respond_to?).with(:invalid_method).and_return(false)
      lambda { subject.invalid_method }.should raise_error(NoMethodError)
    end
  end


end
