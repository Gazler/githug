require 'spec_helper'

describe Githug::Game do
  
  before(:each) do
    @profile = mock
    Githug::Profile.stub(:new).and_return(@profile)
    @game = Githug::Game.new
    @profile.stub(:level).and_return(1)
    @profile.stub(:save)
    @level = mock
    @level.stub(:full_description)
    @level.stub(:setup_level)
    Githug::UI.stub(:puts)
    Githug::Level.stub(:load).and_return(@level)
  end

  it "should have a profile" do
    @game.profile.should eql(@profile)
  end

  it "should show a description if the level is 0" do
    @level.should_not_receive(:solve)
    @profile.stub(:level).and_return(0) 
    @profile.should_receive(:save)
    Githug::UI.should_receive(:puts).with("Welcome to Githug")
    @profile.should_receive(:level=).with(1)
    @game.play_level
  end

  it "should echo congratulations if the level is solved" do
    @level.stub(:solve).and_return(true)
    @profile.should_receive(:level=).with(2)
    Githug::UI.should_receive(:success).with("Congratulations, you have solved the level")
    @game.play_level
  end

  it "should echo congratulations if the level is solved" do
    @level.stub(:solve).and_return(false)
    Githug::UI.should_receive(:error).with("Sorry, this solution is not quite right!")
    @game.play_level
  end

  it "should output the description of the next level" do
    @level.should_receive(:full_description)
    @profile.stub(:level=)
    @game.level_bump
  end

  it "should call setup_level for the next level" do
    @level.should_receive(:setup_level)  
    @profile.stub(:level=)
    @game.level_bump
  end
  
end
