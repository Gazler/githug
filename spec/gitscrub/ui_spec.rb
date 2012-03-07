require 'spec_helper'

require 'spec_helper'

describe Gitscrub::UI do

  before(:each) do
    @ui = Gitscrub::UI
    @out = StringIO.new
    @ui.out_string = @out
  end

  it "should put to the stream" do
    @ui.puts("hello") 
    @out.string.should eql("hello\n")
  end
  
end
