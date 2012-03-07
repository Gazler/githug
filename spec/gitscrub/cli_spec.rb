require 'spec_helper'
require 'gitscrub/cli'

describe Gitscrub::CLI do
  
  before(:each) do
    @cli = Gitscrub::CLI.new
  end

  it "should start a game" do
    Gitscrub::UI.should_receive(:word_box).with("Gitscrub")
    @cli.setup
  end
  
end
