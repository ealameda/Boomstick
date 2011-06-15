require 'spec_helper'

feature "Signup Process", %q{
  In order to save coupons
  As a Consumer
  I want to create a new account
} do

  background do
    sign_out!
  end

  scenario "when I go through the normal process" do
    offers_response = Typhoeus::Response.new(:code => 200, :headers => "whatever", :time => 0.1, :body => offers_call_response! )
    get_request_check!("http://expo.zavers.com/api/brand_offers.xml", {:page=>1, :per_page=>10}, offers_response)

    visit "/"
    click_link "Signup Today!"
    current_path.should == signup_path
    page.should have_content("Signup Today")
    fill_in('Email Address', :with => "JoeDirt@gmail.com")
    fill_in('Zip Code', :with => "66062")
    fill_in('Password', :with => "pass")
    consumer_response = Typhoeus::Response.new(:code => 200, :headers => "whatever", :time => 0.1, :body => consumer_response! )
    post_request_check!("http://expo.zavers.com/api/consumer.xml", {:type_id => "email", :id_value => "JoeDirt@gmail.com", :password => "pass", :zip_code => "66062"}, consumer_response)
    click_button "Sign Up"
    current_path.should == login_path
    page.should have_content("Consumer Account Created. Sign in Below.")
  end

  scenario "but can't when I don't submit the mandatory email field" do
    visit "/signup"
    current_path.should == signup_path
    page.should have_content("Signup Today")
    fill_in('Zip Code', :with => "66062")
    fill_in('Password', :with => "pass")
    click_button "Sign Up"
    page.should have_content("Signup Today")
    page.should have_content("Email is invalid")
  end

  scenario "but can't when I don't submit the mandatory password field" do
    visit "/signup"
    current_path.should == signup_path
    page.should have_content("Signup Today")
    fill_in('Zip Code', :with => "66062")
    fill_in('Email Address', :with => "JoeDirt@gmail.com")
    click_button "Sign Up"
    page.should have_content("Signup Today")
    page.should have_content("Password is too short (minimum is 4 characters)")
  end

  scenario "but can't when I don't submit the mandatory zip code field" do
    visit "/signup"
    current_path.should == signup_path
    page.should have_content("Signup Today")
    fill_in('Password', :with => "pass")
    fill_in('Password', :with => "pass")
    click_button "Sign Up"
    page.should have_content("Signup Today")
    page.should have_content("Email is invalid and Zip code can't be blank")
  end

  scenario "but can't due to error raised by express lane" do
    visit "/signup"
    current_path.should == signup_path
    page.should have_content("Signup Today")
    fill_in('Email Address', :with => "JoeDirt@gmail.com")
    fill_in('Zip Code', :with => "66062")
    fill_in('Password', :with => "pass")
    consumer_response = Typhoeus::Response.new(:code => 475, :headers => "whatever", :time => 0.1, :body => error_response! )
    post_request_check!("http://expo.zavers.com/api/consumer.xml", {:type_id => "email", :id_value => "JoeDirt@gmail.com", :password => "pass", :zip_code => "66062"}, consumer_response)
    click_button "Sign Up"
    current_path.should_not == login_path
    page.should have_content("Signup Today")
    page.should have_content("The Consumer ID that was provided could not be matched to a Consumer.")
  end

  scenario "but can't due to a malformed (500) error raised by express lane" do
    visit "/signup"
    current_path.should == signup_path
    page.should have_content("Signup Today")
    fill_in('Email Address', :with => "JoeDirt@gmail.com")
    fill_in('Zip Code', :with => "66062")
    fill_in('Password', :with => "pass")
    consumer_response = Typhoeus::Response.new(:code => 475, :headers => "whatever", :time => 0.1, :body => "" )
    post_request_check!("http://expo.zavers.com/api/consumer.xml", {:type_id => "email", :id_value => "JoeDirt@gmail.com", :password => "pass", :zip_code => "66062"}, consumer_response)
    click_button "Sign Up"
    current_path.should_not == login_path
    page.should have_content("Signup Today")
    page.should have_content("We're sorry, but something went wrong. We've been notified about this issue and we'll take a look at it shortly.")
  end
end


