require 'spec_helper'

require 'spec_helper'

describe Githug::UI do

  before(:each) do
    @ui = Githug::UI
    @out = StringIO.new
    @in = StringIO.new
    @ui.out_stream = @out
    @ui.in_stream = @in
  end

  it "should put to the stream" do
    @ui.puts("hello")
    @out.string.should eql("hello\n")
  end

  it "should print an empty line with no arguments" do
    @ui.puts
    @out.string.should eql("\n")
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

  it "should make a wordbox" do
    word_box = <<-eof
********************************************************************************
*                                    Githug                                    *
********************************************************************************
    eof
    @ui.word_box("Githug")
    @out.string.should eql(word_box)
  end

  it "should print a correct wordbox for uneven msg length" do
    @ui.word_box("odd",80)
    printed = @out.string.lines
    first_size = printed.first.chomp.length

    printed.map{ |line| line.chomp.length.should eq(first_size) }
  end

  it "should request text input" do
    @in.puts "bar"
    @in.rewind
    @ui.request("foo").should == "bar"
    @out.string.should == "foo "
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

  describe "Non Windows Platform" do
    before(:each) do
      ENV.stub(:[]).with("OS").and_return(nil)
    end

    it "should print out a success message in green" do
      @ui.success("success")
      @out.string.should eql("\033[32msuccess\033[0m\n")
    end

    it "should print out a error message in red" do
      @ui.error("error")
      @out.string.should eql("\033[31merror\033[0m\n")
    end

  end

  describe "Non Windows Platform" do

    before(:each) do
      ENV.stub(:[]).with("OS").and_return("Windows_NT")
    end

    it "should print out a success message in white" do
      @ui.success("success")
      @out.string.should eql("success\n")
    end

    it "should print out a error message in white" do
      @ui.error("error")
      @out.string.should eql("error\n")
    end

  end


end
