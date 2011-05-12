require 'spec_helper'

describe ConsumersController do
  describe "current_user" do
    it "should return nil if no user is logged in" do
      subject.send(:current_user).should == nil
    end

    it "should return the consumer if one is logged in" do
      consumer = {consumer: 1234}
      subject.should_receive(:session).twice.and_return(consumer)
      subject.send(:current_user).should == 1234
    end
  end

  describe "current_user=" do
    it "should assign the object to the session" do
      consumer = {"consumer"=>1234}
      subject.send(:current_user=, consumer)
      session[:consumer].should == consumer
      assigns[:current_user].should == consumer
    end
  end

  describe "normalize_page_number" do
    it "should return 1 if input is nil" do
      subject.send(:normalize_page_number, nil).should == 1
    end

    it "should return 1 if input is empty string" do
      subject.send(:normalize_page_number, "").should == 1
    end

    it "should return 1 if input is 0" do
      subject.send(:normalize_page_number, 0).should == 1
    end

    it "should return 1 if input is negative" do
      subject.send(:normalize_page_number, -1).should == 1
    end

    it "should return 1 if input is 1" do
      subject.send(:normalize_page_number, 1).should == 1
    end

    it "should return 2 if input is 2" do
      subject.send(:normalize_page_number, 2).should == 2
    end

    it "should return 20 if input is '20'" do
      subject.send(:normalize_page_number, "20").should == 20
    end
  end
end
