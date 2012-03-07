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


  it "should request text input" do
    @in.puts "bar"
    @in.rewind
    @ui.request("foo").should == "bar"
    @out.string.should == "foo"
  end

  it "should ask for yes/no and return true when yes" do
    @ui.should_receive(:request).with('foo? [yn] ').and_return('y')
    @ui.ask("foo?").should be_true
  end
  
  it "should ask for yes/no and return false when no" do
    @ui.stub(:request).and_return('n')
    @ui.ask("foo?").should be_false
  end
  
  it "should ask for yes/no and return false for any input" do
    @ui.stub(:request).and_return('aklhasdf')
    @ui.ask("foo?").should be_false
  end
  
end
