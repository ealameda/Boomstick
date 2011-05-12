require 'spec_helper'

feature "Home Page", %q{
  In order to have a decent site
  As a Partner
  I want to have a web site that has a 
} do

  background do
    @offer1 = mock(:offer_summary => "Shop Smart", :display_name => '...', :short_description => "Shop S Mart", 
                  :campaign_end_date => "2011-12-1", :image_url => "", :coupon_id => nil, :coupon_state => "delivered")

    @offer2 = mock(:offer_summary => "Big Money", :display_name => 'No Whammies', :short_description => "STOP",
                  :campaign_end_date => "2011-12-1", :image_url => "", :coupon_id => nil, :coupon_state => "delivered")
  end

  scenario "Home page that displays sample brand offers" do
    Zavers.stub(:brand_offers).and_return mock(OffersList, :offers => [@offer1, @offer2], :total_count => 2, :coupon_ids => [])
    sign_out!
    visit "/"
    page.should have_content "Zavers Reference Application"
    page.should have_content "Shop Smart"
    page.should have_content "Shop S Mart"
    page.should have_content "Big Money"
    page.should have_content "No Whammies"
    page.should have_content "STOP"
  end

  scenario "Home page that should display the login link when not logged in" do
    Zavers.stub(:brand_offers).and_return mock(OffersList, :offers => [@offer1, @offer2], :total_count => 2, :coupon_ids => [])
    sign_out!
    visit "/"
    page.should have_link "Login"
    page.should have_link "Signup Today!"
  end

  scenario "Home page that should display a welcome message when logged in" do
    Zavers.stub(:offers).and_return mock(OffersList, :offers => [@offer1, @offer2], :total_count => 2, :coupon_ids => [])
    @offer1.stub(:coupon_id).and_return(1234)
    @offer2.stub(:coupon_id).and_return(3456)
    sign_in!
    visit "/"
    page.should have_content "Welcome Eric"
    page.should_not have_link "Login"
  end

  scenario "Brand Offers page that displays manufacturer offers" do
    Zavers.stub(:offers).and_return mock(OffersList, :offers => [@offer1, @offer2], :total_count => 2, :coupon_ids => [])
    sign_in!
    visit "/brand_offers"
    page.should have_content "Zavers Reference Application"
    page.should have_content "Shop Smart"
    page.should have_content "Shop S Mart"
    page.should have_content "Big Money"
    page.should have_content "No Whammies"
    page.should have_content "STOP"
  end

  scenario "Retail Offers page that displays retailer offers" do
    Zavers.stub(:offers).and_return mock(OffersList, :offers => [@offer1, @offer2], :total_count => 2, :coupon_ids => [])
    sign_in!
    visit "/retail_offers"
    page.should have_content "Zavers Reference Application"
    page.should have_content "Shop Smart"
    page.should have_content "Shop S Mart"
    page.should have_content "Big Money"
    page.should have_content "No Whammies"
    page.should have_content "STOP"
  end

  scenario "Retail Offers page that displays a flash message if no offers are available" do
    Zavers.stub(:offers).and_return mock(OffersList, :offers => [], :total_count => 0, :coupon_ids => [])
    sign_in!
    visit "/retail_offers"
    page.should have_content "There are currently no offers for this retailer"
  end

  scenario "Saved Offers page that displays the consumers saved offers" do
    Zavers.stub(:offers).and_return mock(OffersList, :offers => [@offer1, @offer2], :total_count => 2, :coupon_ids => [])
    sign_in!
    visit "/saved_offers"
    page.should have_content "Zavers Reference Application"
    page.should have_content "Shop Smart"
    page.should have_content "Shop S Mart"
    page.should have_content "Big Money"
    page.should have_content "No Whammies"
    page.should have_content "STOP"
  end

  scenario "Saved Offers page that displays a flash message if there are no saved offers" do
    Zavers.stub(:offers).and_return mock(OffersList, :offers => [], :total_count => 0, :coupon_ids => [])
    sign_in!
    visit "/saved_offers"
    page.should have_content "You currently don't have any saved offers"
  end

  # scenario "a page the processes Offer Events sent from the Client" do
    # Time.stub_chain(:now, :iso8601).and_return("2011-05-11T09:42:34-05:00")
    # sign_in!
    # Zavers.should_receive(:offer_event).with({:consumer_id => "962", :coupon_id => "12345", :event => "deliver", :datetime =>"2011-05-11T09:42:34-05:00"})
    # visit "/deliver/12345"
  # end
end

