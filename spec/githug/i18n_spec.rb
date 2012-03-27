require 'spec_helper'

describe I18n do
  describe "exists?" do
    it "should return true if the translation exists" do
      I18n.stub(:t!).and_return("some response") 
      I18n.exists?("a translation").should eql(true)
    end

    it "should return false if the translation doesn't exist" do
      I18n.exists?("a translation").should eql(false)
    end
     
  end
end
