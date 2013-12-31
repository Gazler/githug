require 'spec_helper'

require 'spec_helper'

describe Githug::UI do

  let(:ui_out) { StringIO.new }
  let(:ui_in) { StringIO.new }

  before(:each) do
    subject.out_stream = ui_out
    subject.in_stream = ui_in
  end

  it "puts to the stream" do
    subject.puts("hello")
    ui_out.string.should eql("hello\n")
  end

  it "prints an empty line with no arguments" do
    subject.puts
    ui_out.string.should eql("\n")
  end

  it "prints without a new line" do
    subject.print("hello")
    ui_out.string.should eql("hello")
  end

  it "fetches gets from input stream" do
    ui_in.puts "bar"
    ui_in.rewind
    subject.gets.should == "bar\n"
  end

  it "makes a wordbox" do
    word_box = <<-eof
********************************************************************************
*                                    Githug                                    *
********************************************************************************
    eof
    subject.word_box("Githug")
    ui_out.string.should eql(word_box)
  end

  it "prints a correct wordbox for uneven msg length" do
    subject.word_box("odd",80)
    printed = ui_out.string.lines
    first_size = printed.first.chomp.length

    printed.map{ |line| line.chomp.length.should eq(first_size) }
  end

  it "requests text input" do
    ui_in.puts "bar"
    ui_in.rewind
    subject.request("foo").should == "bar"
    ui_out.string.should == "foo "
  end

  it "asks for yes/no and return true when yes" do
    subject.should_receive(:request).with('foo? [yn] ').and_return('y')
    subject.ask("foo?").should be_true
  end

  it "asks for yes/no and return false when no" do
    subject.stub(:request).and_return('n')
    subject.ask("foo?").should be_false
  end

  it "asks for yes/no and return false for any input" do
    subject.stub(:request).and_return('aklhasdf')
    subject.ask("foo?").should be_false
  end

  describe "Non Windows Platform" do
    before(:each) do
      ENV.stub(:[]).with("OS").and_return(nil)
    end

    it "prints out a success message in green" do
      subject.success("success")
      ui_out.string.should eql("\033[32msuccess\033[0m\n")
    end

    it "prints out a error message in red" do
      subject.error("error")
      ui_out.string.should eql("\033[31merror\033[0m\n")
    end

  end

  describe "Windows Platform" do

    before(:each) do
      ENV.stub(:[]).with("OS").and_return("Windows_NT")
    end

    it "prints out a success message in white" do
      subject.success("success")
      ui_out.string.should eql("success\n")
    end

    it "prints out a error message in white" do
      subject.error("error")
      ui_out.string.should eql("error\n")
    end

  end


end
