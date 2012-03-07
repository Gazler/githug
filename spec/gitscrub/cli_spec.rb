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
    @cli.make_directory
  end

  it "should not make a directory if you are in the game directory" do
    Dir.stub(:pwd).and_return("/home/git_scrub")
    Gitscrub::UI.should_not_receive(:ask)
    @cli.make_directory 
  end

  it "should create a directory if one does not exist" do
    Gitscrub::UI.stub(:ask).and_return(false) 
    lambda {@cli.make_directory}.should raise_error(SystemExit)
  end

  it "should check the current solution" do
    @cli.check.should eql(true) 
  end

  it "should reset the current level" do
    @cli.check.should eql(true) 
  end
  
end
