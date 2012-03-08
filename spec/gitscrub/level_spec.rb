require 'spec_helper'
require 'grit'

describe Gitscrub::Level do
  
  before(:each) do
    @file = <<-eof
difficulty 1
description "A test description"
setup do
  "test"
end
solution do
  Grit::Repo.new("gitscrub/notadir")
end
    eof
    File.stub(:exists?).and_return(true)
    File.stub(:read).and_return(@file)
    @level = Gitscrub::Level.load(1)
  end

  it "should load the level" do
    File.stub(:dirname).and_return("")
    File.should_receive(:read).with('/../../levels/init.rb').and_return(@file)
    level = Gitscrub::Level.load(1)
    level.ldifficulty.should eql(1)
    level.ldescription.should eql("A test description")
  end

  it "should return false if the level does not exist" do
    File.stub(:exists?).and_return(false)
    Gitscrub::Level.load(1).should eql(false)
  end

  it "should solve the problem" do
    @level.solve.should eql(false)
  end

  it "should return true if the requirements have been met" do
    Grit::Repo.stub(:new).and_return(true) 
    @level.solve.should eql(true)
  end

  it "should display a full description" do
    Gitscrub::UI.stub(:puts)
    Gitscrub::UI.should_receive(:puts).with("Level: 1")
    Gitscrub::UI.should_receive(:puts).with("Difficulty: *")
    Gitscrub::UI.should_receive(:puts).with(@level.ldescription)
    @level.full_description
  end

  it "should call setup" do
    @level.setup_level.should eql("test") 
  end

  it "should mixin UI" do
    Gitscrub::Level.ancestors.should include(Gitscrub::UI)
  end

  it "should initialize a repository when repo is called" do
    repo = mock
    Gitscrub::Repository.should_receive(:new).and_return(repo)
    @level.repo.should equal(repo)
    Gitscrub::Repository.should_not_receive(:new).and_return(repo)
    @level.repo.should equal(repo)
  end
  
end
