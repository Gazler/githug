require 'spec_helper'
require 'grit'

describe Gitscrub::Level do
  
  before(:each) do
    @file = <<-eof
difficulty 1
description "A test description"
solution do
  Grit::Repo.new("gitscrub/notadir")
end
    eof
    File.stub(:read).and_return(@file)
    @level = Gitscrub::Level.load(1)
  end

  it "should load the level" do
    File.should_receive(:read).with('./levels/1.rb').and_return(@file)
    level = Gitscrub::Level.load(1)
    level.ldifficulty.should eql(1)
    level.ldescription.should eql("A test description")
  end

  it "should solve the problem" do
    @level.solve.should eql(false)
  end

  it "should return true if the requirements have been met" do
    Grit::Repo.stub(:new).and_return(true) 
    @level.solve.should eql(true)
  end
  
end
