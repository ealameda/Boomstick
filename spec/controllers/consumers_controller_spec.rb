require 'spec_helper'

describe ConsumersController do

  describe "GET 'new'" do
    before(:each) do
      sign_out!
    end

    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "POST 'create'" do
    before(:each) do
      sign_out!
      @mock_response = Typhoeus::Response.new(:code => 200, :headers => "whatever", :time => 0.1, :body => consumer_response!)
    end

    it "should redirect to login page" do
      Typhoeus::Request.should_receive(:run).and_return(@mock_response)
      post 'create', :local_consumer => {:email => "joe@dirt.com", :password => "pass", :zip_code => "90210"}
      response.should redirect_to(login_path)
    end

    it "should post the consumer parameters to Express Lane" do
      post_request_check!("http://expo.zavers.com/api/consumer.xml", {:type_id => "email", :id_value => "joe@dirt.com", :password => "pass", :zip_code => "90210"}, @mock_response)
      post 'create', :local_consumer => {:email => "joe@dirt.com", :password => "pass", :zip_code => "90210"}
    end

    it "should not post to express lane if the email address is missing" do
      Typhoeus::Request.should_not_receive(:run)
      post 'create', :local_consumer => {:email => nil, :password => "pass", :zip_code => "90210"}

      Typhoeus::Request.should_not_receive(:run)
      post 'create', :local_consumer => {:email => "", :password => "pass", :zip_code => "90210"}

      Typhoeus::Request.should_not_receive(:run).and_return(@mock_response)
      post 'create', :local_consumer => {:password => "pass", :zip_code => "90210"}
    end

    it "should not post to express lane if the password is missing" do
      Typhoeus::Request.should_not_receive(:run)
      post 'create', :local_consumer => {:email => "joe@dirt.com", :password => nil, :zip_code => "90210"}

      Typhoeus::Request.should_not_receive(:run)
      post 'create', :local_consumer => {:email => "joe@dirt.com", :password => "", :zip_code => "90210"}

      Typhoeus::Request.should_not_receive(:run)
      post 'create', :local_consumer => {:email => "joe@dirt.com", :zip_code => "90210"}
    end

    it "should not post to express lane if the zipcode is missing" do
      Typhoeus::Request.should_not_receive(:run)
      post 'create', :local_consumer => {:email => "joe@dirt.com", :password => "pass", :zip_code => nil}

      Typhoeus::Request.should_not_receive(:run)
      post 'create', :local_consumer => {:email => "joe@dirt.com", :password => "pass", :zip_code => ""}

      Typhoeus::Request.should_not_receive(:run)
      post 'create', :local_consumer => {:email => "joe@dirt.com", :password => "pass"}
    end

    it "should redirect to the signup page if consumer create fails from Express Lane" do
      garbage = Typhoeus::Response.new(:code => 500, :headers => "whatever", :time => 0.1, :body => "garbage")
      post_request_check!("http://expo.zavers.com/api/consumer.xml", {:type_id => "email", :id_value => "joe@dirt.com", :password => "pass", :zip_code => "90210"}, garbage)
      post 'create', :local_consumer => {:email => "joe@dirt.com", :password => "pass", :zip_code => "90210"}
      response.should redirect_to(signup_path)
      flash[:notice].should == "We're sorry, but something went wrong. We've been notified about this issue and we'll take a look at it shortly."
    end
  end
end

