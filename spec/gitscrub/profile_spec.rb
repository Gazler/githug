require 'spec_helper'

describe Gitscrub::Profile do
  
  before(:each) do
  end

  it "should load the profile" do
    settings = {:level => 1}
    File.should_receive(:exists?).with(Gitscrub::Profile::PROFILE_FILE).and_return(true)
    File.should_receive(:open).with(Gitscrub::Profile::PROFILE_FILE).and_return("settings")
    YAML.should_receive(:load).with("settings").and_return(settings)
    Gitscrub::Profile.should_receive(:new).with(settings)
    Gitscrub::Profile.load
  end

  it "should load the defaults if the file does not exist" do
    defaults = {:level => 0}
    Gitscrub::Profile.should_receive(:new).with(defaults)
    Gitscrub::Profile.load
  end

  it "should allow method acces to getters and setters" do
    profile = Gitscrub::Profile.load
    profile.level.should eql(0)
    profile.level = 1
    profile.level.should eql(1)
  end

  it "should save the file" do
    profile = Gitscrub::Profile.load
    File.should_receive(:open).with(Gitscrub::Profile::PROFILE_FILE, "w")
    profile.save
  end
  
end
