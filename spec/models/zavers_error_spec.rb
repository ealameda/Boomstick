require 'spec_helper'

describe ZaversError do
  it "should be able to parse a standard Zavers Error" do
    mock_response = Typhoeus::Response.new(:code => 402, :headers => "whatever", :time => 0.1, :body => error_response! )
    get_request_check!("http://expo.zavers.com/api/consumer.xml", {:type_id => "email", :id_value => "ebudd@zavers.com"}, mock_response)
    expect { Zavers.consumer_read({:type_id => "email", :id_value => "ebudd@zavers.com"})}.to raise_exception(ZaversError)
  end

  it "should default to a generic Zavers error in the event of 500 error response" do
    mock_response = Typhoeus::Response.new(:code => 500, :headers => "whatever", :time => 0.1, :body => "adfaslkdfjlkwjerqlwjlkjafsdoi jqwoijfwqefjoqwi nqwoeirj qwoej" )
    get_request_check!("http://expo.zavers.com/api/brand_offers.xml", {}, mock_response)
    expect { Zavers.brand_offers({})}.to raise_exception(ZaversError)
  end
end

