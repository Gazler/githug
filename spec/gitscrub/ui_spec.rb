require 'spec_helper'

require 'spec_helper'

describe Gitscrub::UI do

  before(:each) do
    @ui = Gitscrub::UI
    @out = StringIO.new
    @in = StringIO.new
    @ui.out_stream = @out
    @ui.in_stream = @in
  end

  it "should put to the stream" do
    @ui.puts("hello") 
    @out.string.should eql("hello\n")
  end

  it "should print without a new line" do
    @ui.print("hello")
    @out.string.should eql("hello")
  end

  it "should fetch gets from input stream" do
    @in.puts "bar"
    @in.rewind
    @ui.gets.should == "bar\n"
  end

  it "should make a line" do
    @ui.line
    @out.string.should eql("*"*80+"\n")
  end

  it "should make a wordbox" do
    word_box = <<-eof
********************************************************************************
*                                   Gitscrub                                   *
********************************************************************************
    eof
    @ui.word_box("Gitscrub")
    @out.string.should eql(word_box)
  end
  
end
