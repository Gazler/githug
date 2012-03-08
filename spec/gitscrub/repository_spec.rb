require 'spec_helper'

describe Gitscrub::Repository do
    
  before(:each) do
    @grit = mock
    Grit::Repo.stub(:new).and_return(@grit) 
    @repository = Gitscrub::Repository.new
  end

  it "should call grit on initialize" do
    Grit::Repo.should_receive(:new).and_return(@grit) 
    repo = Gitscrub::Repository.new
    repo.grit.should equal(@grit)
  end

  it "should contain a nil grit if the repo is invalid" do
    Grit::Repo.should_receive(:new).and_raise(Grit::InvalidGitRepositoryError) 
    repo = Gitscrub::Repository.new
    repo.grit.should equal(nil)
  end

end
