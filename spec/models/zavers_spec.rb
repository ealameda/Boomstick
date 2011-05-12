require 'spec_helper'

describe Zavers do
  describe "brand offers" do
    context "with success response" do
      before(:each) do
        @mock_response = Typhoeus::Response.new(:code => 200, :headers => "whatever", :time => 0.1, :body => offers_call_response! )
      end

      it "should make a call an Express Lane Brand Offers call" do
        get_request_check!("http://expo.zavers.com/api/brand_offers.xml", {}, @mock_response)
        Zavers.brand_offers({})
      end

      it "should accept incoming parameters" do
        get_request_check!("http://expo.zavers.com/api/brand_offers.xml", {:per_page => 1, :page => 2 }, @mock_response)
        Zavers.brand_offers({:per_page => 1, :page => 2})
      end

      it "should return an OffersList object upon success" do
        get_request_check!("http://expo.zavers.com/api/brand_offers.xml", {}, @mock_response)
        Zavers.brand_offers({}).should be_a_kind_of(OffersList)
      end
    end

    context "with an error response" do
      it "should raise a ZaversError upon failure" do
        mock_response = Typhoeus::Response.new(:code => 402, :headers => "whatever", :time => 0.1, :body => error_response! )
        get_request_check!("http://expo.zavers.com/api/brand_offers.xml", {}, mock_response)
        expect { Zavers.brand_offers({})}.to raise_exception(ZaversError)
      end
    end
  end

  describe "Consumer Read" do
    context "with success response" do
      before(:each) do
        @mock_response = Typhoeus::Response.new(:code => 200, :headers => "whatever", :time => 0.1, :body => consumer_response! )
      end

      it "should make a call to the Express Lane Consumer Read URL" do
        get_request_check!("http://expo.zavers.com/api/consumer.xml", {:type_id => "email", :id_value => nil}, @mock_response)
        Zavers.consumer_read({})
      end

      it "should accept incoming parameters" do
        get_request_check!("http://expo.zavers.com/api/consumer.xml", {:type_id => "email", :id_value => "ebudd@zavers.com"}, @mock_response)
        Zavers.consumer_read({:type_id => "email", :id_value => "ebudd@zavers.com"})
      end

      it "should return an Consumer object upon success" do
        get_request_check!("http://expo.zavers.com/api/consumer.xml", {:type_id => "email", :id_value => "ebudd@zavers.com"}, @mock_response)
        Zavers.consumer_read({:type_id => "email", :id_value => "ebudd@zavers.com"}).should be_a_kind_of(Consumer)
      end
    end

    context "with an error response" do
      it "should raise a ZaversError upon failure" do
        mock_response = Typhoeus::Response.new(:code => 402, :headers => "whatever", :time => 0.1, :body => error_response! )
        get_request_check!("http://expo.zavers.com/api/consumer.xml", {:type_id => "email", :id_value => "ebudd@zavers.com"}, mock_response)
        expect { Zavers.consumer_read({:type_id => "email", :id_value => "ebudd@zavers.com"})}.to raise_exception(ZaversError)
      end
    end
  end

  describe "Consumer Authenticate" do
    before(:each) do
      @mock_response = Typhoeus::Response.new(:code => 200, :headers => "whatever", :time => 0.1, :body => consumer_response! )
    end

    it "should make a call to the Express Lane Consumer Authenticate URL" do
      post_request_check!("http://expo.zavers.com/api/consumer/authenticate.xml", {:type_id => "email", :id_value => "ebudd@zavers.com", :password => "pass"}, @mock_response)
      Zavers.consumer_authenticate({:type_id => "email", :id_value => "ebudd@zavers.com", :password => "pass"})
    end

    it "should return an Consumer object upon success" do
      post_request_check!("http://expo.zavers.com/api/consumer/authenticate.xml", {:type_id => "email", :id_value => "ebudd@zavers.com", :password => "pass"}, @mock_response)
      Zavers.consumer_authenticate({:type_id => "email", :id_value => "ebudd@zavers.com", :password => "pass"}).should be_a_kind_of(Consumer)
    end
  end

  context "with an error response" do
    it "should raise a ZaversError upon failure" do
      mock_response = Typhoeus::Response.new(:code => 402, :headers => "whatever", :time => 0.1, :body => error_response! )
      post_request_check!("http://expo.zavers.com/api/consumer/authenticate.xml", {:type_id => "email", :id_value => "ebudd@zavers.com", :password => "pass"}, mock_response)
      expect { Zavers.consumer_authenticate({:type_id => "email", :id_value => "ebudd@zavers.com", :password => "pass"})}.to raise_exception(ZaversError)
    end
  end

  describe "Offer Event" do
    before(:each) do
      @mock_response = Typhoeus::Response.new(:code => 200, :headers => "whatever", :time => 0.1, :body => offer_event! )
    end

    it "should make a call to the Express Lane offer event URL" do
      post_request_check!("http://expo.zavers.com/api/consumer/962/coupon/12345.xml", {:consumer_id =>"962", :coupon_id=>"12345", :event=>"deliver", :date_time=>"2011-05-11T09:12:47-05:00"}, @mock_response)
      Zavers.offer_event({:consumer_id => "962", :coupon_id => "12345", :event => "deliver", :date_time => "2011-05-11T09:12:47-05:00"})
    end

    it "should return an Offer Event object upon success" do
      post_request_check!("http://expo.zavers.com/api/consumer/962/coupon/12345.xml", {:consumer_id =>"962", :coupon_id=>"12345", :event=>"deliver", :date_time=>"2011-05-11T09:12:47-05:00"}, @mock_response)
      Zavers.offer_event({:consumer_id => "962", :coupon_id => "12345", :event => "deliver", :date_time => "2011-05-11T09:12:47-05:00"}).should be_a_kind_of(OfferEvent)
    end
  end

  context "with an error response" do
    it "should raise a ZaversError upon failure" do
      mock_response = Typhoeus::Response.new(:code => 402, :headers => "whatever", :time => 0.1, :body => error_response! )
      post_request_check!("http://expo.zavers.com/api/consumer/962/coupon/12345.xml", {:consumer_id =>"962", :coupon_id=>"12345", :event=>"deliver", :date_time=>"2011-05-11T09:12:47-05:00"}, mock_response)
      expect { Zavers.offer_event({:consumer_id => "962", :coupon_id => "12345", :event => "deliver", :date_time => "2011-05-11T09:12:47-05:00"})}.to raise_exception(ZaversError)
    end
  end
end

