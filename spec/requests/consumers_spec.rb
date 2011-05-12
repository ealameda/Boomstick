require 'spec_helper'

feature "Editing Consumer", %q{
  In order to maintain my identity
  As a Consumer
  I want to be able to edit my account
} do

  background do
    @mock_response = Typhoeus::Response.new(:code => 200, :headers => "whatever", :time => 0.1, :body => consumer_response! )
  end

  scenario "and I should not see a edit my account link when I'm not logged in" do
    sign_out!
    visit '/'
    current_path.should == root_path
    page.should have_link "Login"
    page.should_not have_link "Edit My Account"
  end

  scenario "and I should see a edit my account link when I'm logged in" do
    sign_in!
    visit '/'
    current_path.should == root_path
    page.should_not have_link "Login"
    page.should have_link "Edit My Account"
  end

  scenario "when I click 'edit my account' I should be taken to edit consumer page" do
    sign_in!
    visit '/'
    get_request_check!("http://expo.zavers.com/api/consumer.xml", {:type_id => "email", :id_value => "ebudd@zavers.com"}, @mock_response)
    click_link "Edit My Account"
    current_path.should == edit_consumer_path(962)
  end

  scenario "when I click 'edit my account' I should see an error message if consumer lookup fails" do
    sign_in!
    visit '/'
    garbage = Typhoeus::Response.new(:code => 500, :headers => "whatever", :time => 0.1, :body => "garbage")
    get_request_check!("http://expo.zavers.com/api/consumer.xml", {:type_id => "email", :id_value => "ebudd@zavers.com"}, garbage)
    click_link "Edit My Account"
    current_path.should == login_path
    page.should have_content("We're sorry, but something went wrong. We've been notified about this issue and we'll take a look at it shortly.")
  end

  scenario "when viewing the 'edit my account' page - I should see a form with my information" do
    sign_in!
    get_request_check!("http://expo.zavers.com/api/consumer.xml", {:type_id => "email", :id_value => "ebudd@zavers.com"}, @mock_response)
    visit edit_consumer_path(962)
    page.should have_field(:email, :with => 'ebudd@zavers.com')
    page.should have_field(:first_name, :with => 'Eric')
    page.should have_field(:last_name, :with => 'Budd')
    page.should have_field(:address_1, :with => '4567 2nd Ave')
    page.should have_field(:address_2, :with => '')
    page.should have_field(:city, :with => 'Overland Park')
    page.should have_field(:state, :with => 'KS')
    page.should have_field(:zip_code, :with => '66103')
    page.should have_field(:home_number, :with => '')
  end

  scenario "and I should see the updates after I make changes" do
    sign_in!
    get_request_check!("http://expo.zavers.com/api/consumer.xml", {:type_id => "email", :id_value => "ebudd@zavers.com"}, @mock_response)
    visit edit_consumer_path(962)
    page.should have_field(:email, :with => 'ebudd@zavers.com')
    page.should have_field(:first_name, :with => 'Eric')
    page.should have_field(:last_name, :with => 'Budd')
    page.should have_field(:address_1, :with => '4567 2nd Ave')
    page.should have_field(:address_2, :with => '')
    page.should have_field(:city, :with => 'Overland Park')
    page.should have_field(:state, :with => 'KS')
    page.should have_field(:zip_code, :with => '66103')
    page.should have_field(:home_number, :with => '')
    fill_in("First Name", :with => "Joe")
    fill_in("Last Name", :with => "Cool")
    fill_in("Address Line 1", :with => "123 Test")
    fill_in("Address Line 2", :with => "Apt C")
    fill_in("City", :with => "Olathe")
    fill_in("Zip Code", :with => "66062")
    updated_response = Typhoeus::Response.new(:code => 200, :headers => "whatever", :time => 0.1, :body => updated_consumer_response!)
    post_request_check!("http://expo.zavers.com/api/consumer/962.xml",
    {
      :first_name         => "Joe",
      :last_name          => "Cool",
      :address_1          => "123 Test",
      :address_2          => "Apt C",
      :city               => "Olathe",
      :state              => "KS",
      :zip_code           => "66062",
      :home_number        => "",
      :account_news       => "true",
      :program_news       => "false",
      :opt_in_mobile_text => "false"
    }, updated_response)
    get_request_check!("http://expo.zavers.com/api/consumer.xml", {:type_id => "email", :id_value => "ebudd@zavers.com"}, updated_response)
    click_button "Update My Info"
    page.should have_content("Consumer Account Updated")
    page.should have_field(:email, :with => 'ebudd@zavers.com')
    page.should have_field(:first_name, :with => 'Joe')
    page.should have_field(:last_name, :with => 'Cool')
    page.should have_field(:address_1, :with => '123 Test')
    page.should have_field(:address_2, :with => 'Apt C')
    page.should have_field(:city, :with => 'Olathe')
    page.should have_field(:state, :with => 'KS')
    page.should have_field(:zip_code, :with => '66062')
    page.should have_field(:home_number, :with => '')
  end

  scenario "and I should see an error message if the update fails from validations" do
    sign_in!
    get_request_check!("http://expo.zavers.com/api/consumer.xml", {:type_id => "email", :id_value => "ebudd@zavers.com"}, @mock_response)
    visit edit_consumer_path(962)
    page.should have_field(:email, :with => 'ebudd@zavers.com')
    page.should have_field(:first_name, :with => 'Eric')
    page.should have_field(:last_name, :with => 'Budd')
    page.should have_field(:address_1, :with => '4567 2nd Ave')
    page.should have_field(:address_2, :with => '')
    page.should have_field(:city, :with => 'Overland Park')
    page.should have_field(:state, :with => 'KS')
    page.should have_field(:zip_code, :with => '66103')
    page.should have_field(:home_number, :with => '')
    fill_in("First Name", :with => "Joe")
    fill_in("Last Name", :with => "Cool")
    fill_in("Address Line 1", :with => "123 Test")
    fill_in("Address Line 2", :with => "Apt C")
    fill_in("City", :with => "Olathe")
    fill_in("Zip Code", :with => "")
    Typhoeus::Request.should_not_receive(:run)
    click_button "Update My Info"
    page.should have_content("Zip code can't be blank")
  end

  scenario "and I should see an error message if the update fails from Express Lane" do
    sign_in!
    get_request_check!("http://expo.zavers.com/api/consumer.xml", {:type_id => "email", :id_value => "ebudd@zavers.com"}, @mock_response)
    visit edit_consumer_path(962)
    page.should have_field(:email, :with => 'ebudd@zavers.com')
    page.should have_field(:first_name, :with => 'Eric')
    page.should have_field(:last_name, :with => 'Budd')
    page.should have_field(:address_1, :with => '4567 2nd Ave')
    page.should have_field(:address_2, :with => '')
    page.should have_field(:city, :with => 'Overland Park')
    page.should have_field(:state, :with => 'KS')
    page.should have_field(:zip_code, :with => '66103')
    page.should have_field(:home_number, :with => '')
    fill_in("First Name", :with => "Joe")
    fill_in("Last Name", :with => "Cool")
    fill_in("Address Line 1", :with => "123 Test")
    fill_in("Address Line 2", :with => "Apt C")
    fill_in("City", :with => "Olathe")
    fill_in("Zip Code", :with => "66062")
    updated_response = Typhoeus::Response.new(:code => 400, :headers => "whatever", :time => 0.1, :body => error_response!)
    post_request_check!("http://expo.zavers.com/api/consumer/962.xml",
    {
      :first_name         => "Joe",
      :last_name          => "Cool",
      :address_1          => "123 Test",
      :address_2          => "Apt C",
      :city               => "Olathe",
      :state              => "KS",
      :zip_code           => "66062",
      :home_number        => "",
      :account_news       => "true",
      :program_news       => "false",
      :opt_in_mobile_text => "false"
    }, updated_response)
    get_request_check!("http://expo.zavers.com/api/consumer.xml", {:type_id => "email", :id_value => "ebudd@zavers.com"}, @mock_response)
    click_button "Update My Info"
    page.should have_content("The Consumer ID that was provided could not be matched to a Consumer.")
    page.should have_field(:email, :with => 'ebudd@zavers.com')
    page.should have_field(:first_name, :with => 'Eric')
    page.should have_field(:last_name, :with => 'Budd')
    page.should have_field(:address_1, :with => '4567 2nd Ave')
    page.should have_field(:address_2, :with => '')
    page.should have_field(:city, :with => 'Overland Park')
    page.should have_field(:state, :with => 'KS')
    page.should have_field(:zip_code, :with => '66103')
    page.should have_field(:home_number, :with => '')
  end
end

