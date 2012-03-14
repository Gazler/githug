require 'spec_helper'

describe Githug::Profile do
  
  before(:each) do
  end

  it "should load the profile" do
    settings = {:level => 1}
    File.should_receive(:exists?).with(Githug::Profile::PROFILE_FILE).and_return(true)
    File.should_receive(:open).with(Githug::Profile::PROFILE_FILE).and_return("settings")
    YAML.should_receive(:load).with("settings").and_return(settings)
    Githug::Profile.should_receive(:new).with(settings)
    Githug::Profile.load
  end

  it "should load the defaults if the file does not exist" do
    defaults = {:level => 0}
    Githug::Profile.should_receive(:new).with(defaults)
    Githug::Profile.load
  end

  it "should allow method acces to getters and setters" do
    profile = Githug::Profile.load
    profile.level.should eql(0)
    profile.level = 1
    profile.level.should eql(1)
  end

  it "should save the file" do
    profile = Githug::Profile.load
    File.should_receive(:open).with(Githug::Profile::PROFILE_FILE, "w")
    profile.save
  end
  
end
