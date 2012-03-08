require 'spec_helper'
require 'gitscrub/cli'

describe Gitscrub::CLI do
  
  before(:each) do
    game = mock.as_null_object
    @cli = Gitscrub::CLI.new
    Gitscrub::Game.stub(:new).and_return(game)
  end

  it "should print the logo" do
    Gitscrub::UI.should_receive(:word_box).with("Gitscrub")
    @cli.stub(:make_directory) 
    @cli.setup
  end

  it "should create a directory if one does not exist" do
    Gitscrub::UI.stub(:ask).and_return(true) 
    Dir.should_receive(:mkdir).with("./git_scrub")
    Dir.should_receive(:chdir).with("git_scrub")
    File.should_receive(:open).with(".gitignore", "w").and_return(true)
    @cli.make_directory
  end

  it "should not make a directory if you are in the game directory" do
    Dir.stub(:pwd).and_return("/home/git_scrub")
    Gitscrub::UI.should_not_receive(:ask)
    @cli.make_directory 
  end

  it "should exit if the user selects no" do
    Gitscrub::UI.stub(:ask).and_return(false) 
    lambda {@cli.make_directory}.should raise_error(SystemExit)
  end

  it "should prompt to change into the directory if it exists" do
    File.stub(:exists?).and_return(true) 
    Gitscrub::UI.should_receive(:puts).with("Please change into the git_scrub directory")
    lambda {@cli.make_directory}.should raise_error(SystemExit)
  end

  it "should check the current solution" do
    @cli.check.should eql(true) 
  end

  describe "reset" do
    
    before(:each) do
      @level = mock
      @profile = mock
      @profile.stub(:level).and_return(1)
      Gitscrub::Profile.stub(:load).and_return(@profile)
      Gitscrub::Level.stub(:load).and_return(@level)
    end
    
    it "should reset the current level" do
      @level.should_receive(:setup_level)
      @level.should_receive(:full_description)
      Gitscrub::UI.should_receive(:word_box).with("Gitscrub")
      Gitscrub::UI.should_receive(:puts).with("resetting level")
      @cli.reset
    end

    it "should not reset if the level cannot be loaded" do
      Gitscrub::Level.stub(:load).and_return(false)
      @level.should_not_receive(:setup_level)
      @level.should_not_receive(:full_description)
      Gitscrub::UI.should_not_receive(:word_box).with("Gitscrub")
      Gitscrub::UI.should_not_receive(:puts).with("resetting level")
      @cli.reset
    end
  end  
  
end
