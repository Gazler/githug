require 'spec_helper'
require 'githug/cli'

describe Githug::CLI do

  before(:each) do
    game = mock.as_null_object
    @cli = Githug::CLI.new
    Githug::Game.stub(:new).and_return(game)
  end

  it "should print the logo" do
    Githug::UI.should_receive(:word_box).with("Githug")
    @cli.stub(:make_directory)
    @cli.play
  end

  it "should create a directory if one does not exist" do
    Githug::UI.stub(:ask).and_return(true)
    Dir.should_receive(:mkdir).with("./git_hug")
    Dir.should_receive(:chdir).with("git_hug")
    @cli.make_directory
  end

  it "should not make a directory if you are in the game directory" do
    Dir.stub(:pwd).and_return("/home/git_hug")
    Githug::UI.should_not_receive(:ask)
    @cli.make_directory
  end

  it "should exit if the user selects no" do
    Githug::UI.stub(:ask).and_return(false)
    lambda {@cli.make_directory}.should raise_error(SystemExit)
  end

  it "should prompt to change into the directory if it exists" do
    File.stub(:exists?).and_return(true)
    Githug::UI.should_receive(:puts).with("Please change into the git_hug directory")
    lambda {@cli.make_directory}.should raise_error(SystemExit)
  end

  describe "test" do
    it "should perform a test run of the level" do
      level = mock
      game = mock
      @cli.stub(:make_directory)
      Githug::Level.should_receive(:load_from_file).with("/foo/bar/test/level.rb").and_return(level)
      Githug::Game.stub(:new).and_return(game)
      game.should_receive(:test_level).with(level, anything)
      @cli.test("/foo/bar/test/level.rb")
    end
  end

  describe "level methods" do
    before(:each) do
      @level = mock
      @profile = mock
      @profile.stub(:level).and_return(1)
      Githug::Profile.stub(:load).and_return(@profile)
      Githug::Level.stub(:load).and_return(@level)
      Githug::Level.stub(:load_from_file).with("/foo/bar/level.rb").and_return(@level)
    end

    it "should call the hint method on the level" do
      @level.should_receive(:show_hint)
      @cli.hint
    end

    describe "reset" do


      it "should reset the current level" do
        @level.should_receive(:setup_level)
        @level.should_receive(:full_description)
        Githug::UI.should_receive(:word_box).with("Githug")
        Githug::UI.should_receive(:puts).with("resetting level")
        @cli.reset
      end

      it "should not reset if the level cannot be loaded" do
        Githug::Level.stub(:load).and_return(false)
        @level.should_not_receive(:setup_level)
        @level.should_not_receive(:full_description)
        Githug::UI.should_receive(:error).with("Level does not exist")
        @cli.reset
      end

      it "should reset the level with a path" do
        @level.should_receive(:setup_level)
        @level.should_receive(:full_description)
        Githug::UI.should_receive(:word_box).with("Githug")
        Githug::UI.should_receive(:puts).with("resetting level")
        @cli.reset("/foo/bar/level.rb")
      end
    end

  end

end
