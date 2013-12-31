require 'spec_helper'
require 'githug/cli'

describe Githug::CLI do

  before(:each) do
    game = mock.as_null_object
    Githug::Game.stub(:new).and_return(game)
  end

  it "prints the logo" do
    Githug::UI.should_receive(:word_box).with("Githug")
    subject.stub(:make_directory!)
    subject.play
  end

  it "creates a directory if one does not exist" do
    Githug::UI.stub(:ask).and_return(true)
    Dir.should_receive(:mkdir).with("./git_hug")
    Dir.should_receive(:chdir).with("git_hug")
    subject.make_directory!
  end

  it "does not create a directory if you are in the game directory" do
    Dir.stub(:pwd).and_return("/home/git_hug")
    Githug::UI.should_not_receive(:ask)
    subject.make_directory!
  end

  it "exits if the user selects no" do
    Githug::UI.stub(:ask).and_return(false)
    lambda {subject.prompt_githug_directory!}.should raise_error(SystemExit)
  end

  it "prompts to change into the directory if it exists" do
    File.stub(:exists?).and_return(true)
    Githug::UI.should_receive(:puts).with("Please change into the git_hug directory")
    lambda {subject.check_githug_directory!}.should raise_error(SystemExit)
  end

  describe "#test" do
    it "performs a test run of the level" do
      level = mock
      game = mock
      subject.stub(:make_directory!)
      Githug::Level.should_receive(:load_from_file).with("/foo/bar/test/level.rb").and_return(level)
      Githug::Game.stub(:new).and_return(game)
      game.should_receive(:test_level).with(level, anything)
      subject.test("/foo/bar/test/level.rb")
    end
  end

  describe "level methods" do

    let(:level) { mock }
    let(:profile) { mock }

    before(:each) do
      profile.stub(:level).and_return(1)
      Githug::Profile.stub(:load).and_return(profile)
      Githug::Level.stub(:load).and_return(level)
      Githug::Level.stub(:load_from_file).with("/foo/bar/level.rb").and_return(level)
    end

    it "calls the hint method on the level" do
      level.should_receive(:show_hint)
      subject.hint
    end

    describe "#reset" do


      it "resets the current level" do
        level.should_receive(:setup_level)
        level.should_receive(:full_description)
        Githug::UI.should_receive(:word_box).with("Githug")
        Githug::UI.should_receive(:puts).with("resetting level")
        subject.reset
      end

      it "does not reset if the level cannot be loaded" do
        Githug::Level.stub(:load).and_return(false)
        level.should_not_receive(:setup_level)
        level.should_not_receive(:full_description)
        Githug::UI.should_receive(:error).with("Level does not exist")
        subject.reset
      end

      it "resets the level with a level name" do
        level.should_receive(:setup_level)
        level.should_receive(:full_description)
        profile = mock
        Githug::Profile.stub(:load).and_return(profile)
        profile.should_receive(:set_level).with("add")
        Githug::Level.should_receive(:load).with("add").and_return(level)
        Githug::UI.should_receive(:word_box).with("Githug")
        Githug::UI.should_receive(:puts).with("resetting level")
        subject.reset("add")
      end

      it "resets the level with a path" do
        level.should_receive(:setup_level)
        level.should_receive(:full_description)
        Githug::UI.should_receive(:word_box).with("Githug")
        Githug::UI.should_receive(:puts).with("resetting level")
        subject.reset("/foo/bar/level.rb")
      end
    end

  end

  describe "#levels" do

    it "prints the levels and their numbers" do
      Githug::Level.stub(:list).and_return(["commit", "add"])
      Githug::UI.should_receive(:puts).with(["#1: commit", "#2: add"])
      subject.levels
    end
  end

end
