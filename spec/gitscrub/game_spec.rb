require 'spec_helper'

describe Gitscrub::Game do
  
  before(:each) do
    @game = Gitscrub::Game.new
  end

  it "should start a game" do
    @game.start.should eql(true)  
  end
  
end
