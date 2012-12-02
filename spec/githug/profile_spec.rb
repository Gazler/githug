require 'spec_helper'

describe Githug::Profile do

  it "should load the profile" do
    settings = {:level => 1, :current_attempts => 0, :current_hint_index => 0, :current_levels => [], :completed_levels => []}
    File.should_receive(:exists?).with(Githug::Profile::PROFILE_FILE).and_return(true)
    File.should_receive(:open).with(Githug::Profile::PROFILE_FILE).and_return("settings")
    YAML.should_receive(:load).with("settings").and_return(settings)
    Githug::Profile.should_receive(:new).with(settings)
    Githug::Profile.load
  end

  it "should load the defaults if the file does not exist" do
    defaults = {:level => nil, :current_attempts => 0, :current_hint_index => 0, :current_levels => [], :completed_levels => []}
    File.should_receive(:exists?).with(Githug::Profile::PROFILE_FILE).and_return(false)
    Githug::Profile.should_receive(:new).with(defaults)
    Githug::Profile.load
  end

  it "should allow method acces to getters and setters" do
    profile = Githug::Profile.load
    profile.level.should eql(nil)
    profile.level = 1
    profile.level.should eql(1)
  end

  it "should save the file" do
    profile = Githug::Profile.load
    File.should_receive(:open).with(Githug::Profile::PROFILE_FILE, "w")
    profile.save
  end

  describe "level_bump" do
    before(:each) do
      @profile = Githug::Profile.load
      @levels = Githug::Level::LEVELS
      Githug::Level::LEVELS = ["init", "add", "rm", "rm_cached", "diff"]
      @profile.level = "init"
      @profile.should_receive(:save)
    end

    after(:each) do
      Githug::Level::LEVELS = @levels
    end

    it "should bump the level" do
      @profile.level_bump.should eql("add")
    end

    it "should reset the current_attempts" do
      @profile.current_attempts = 1
      @profile.level_bump
      @profile.current_attempts.should eql(0)
    end

    it "should set the level to the first incomplete level" do
      @profile.settings.stub(:[]).with(:level).and_return("rm_cached")
      @profile.settings.stub(:[]).with(:completed_levels).and_return(["init", "add"])
      @profile.level_bump.should eql("rm")
    end
  end


end
