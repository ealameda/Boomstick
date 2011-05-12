require 'spec_helper'

feature "Login", %q{
  In order to save coupons
  As a consumer
  I want to be presented with a login form
} do

  scenario "Visiting Login Page" do
    visit "/login"
    page.should have_content "Login"
    page.should have_content "Email"
    page.should have_field "identifier"
    page.should have_content "Password"
    page.should have_field "password"
  end

  scenario "Logging in" do
    visit "/login"
    fill_in('Email', :with => "JoeDirt@gmail.com")
    fill_in('Password', :with => "pass")
    Zavers.should_receive(:consumer_authenticate).with(:type_id => "email", :id_value => "JoeDirt@gmail.com", :password => "pass").and_return(Consumer.parse(consumer_response!))
    click_button "Login"
    page.should have_content "Logged in Eric Successfully"
  end

  scenario "Logging out" do
    visit "/login"
    fill_in('Email', :with => "JoeDirt@gmail.com")
    fill_in('Password', :with => "pass")
    Zavers.should_receive(:consumer_authenticate).with(:type_id => "email", :id_value => "JoeDirt@gmail.com", :password => "pass").and_return(Consumer.parse(consumer_response!))
    click_button "Login"
    page.should have_content "Logged in Eric Successfully"
    visit "/logout"
    page.should have_content "Logged Out Successfully"
  end
end

