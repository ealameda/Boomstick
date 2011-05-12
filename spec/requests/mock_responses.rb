def get_request_check!(url, params={}, response)
    Typhoeus::Request.should_receive(:run).with(url,
     {:method=>:get, :user_agent=>"Zavers Reference Agent", :username=>11111, :password=>22222, :params=>params}).and_return(response)
end

def post_request_check!(url, params={}, response)
    Typhoeus::Request.should_receive(:run).with(url,
     {:method=>:post, :user_agent=>"Zavers Reference Agent", :username=>11111, :password=>22222, :params=>params}).and_return(response)
end

def offers_call_response!
   <<-STRING
    <?xml version='1.0' encoding='utf-8' ?>
    <catalog>
    <offers count='1' total_count='32'></offers>
    <offer>
    <campaign_id>20575</campaign_id>
    <company_id>289</company_id>
    <company_name>AOL</company_name>
    <campaign_start_date>2011-04-15T00:00:00-05:00</campaign_start_date>
    <campaign_end_date>2011-07-22T23:59:59-05:00</campaign_end_date>
    <display_name>Save 20 cents off your next grocery bill, </display_name>
    <learn_more_text>Direct-to-Card coupons are easy to redeem. Simply swipe your store savings card at checkout for automatic savings. (Ref. 945)
    </learn_more_text>
    <short_description>courtesy of Shortcuts</short_description>
    <long_description></long_description>
    <offer_summary>Save 70&#162;</offer_summary>
    <points_required></points_required>
    <terms_and_conditions></terms_and_conditions>
    <image_url>http://expo.zavers.com/shared/images/product_images/0000/2293/aol_test_image_2_thumb.jpg</image_url>
    <learn_more_image_url></learn_more_image_url>
    <learn_more_image_alt_text>Direct-to-Card coupons are easy to redeem.</learn_more_image_alt_text>
    <video_url></video_url>
    <audio_url></audio_url>
    <save_button_url>http://expo.zavers.com/images/zavers_consumer/zavers_save_it.png</save_button_url>
    <save_button_animation_url>http://expo.zavers.com/images/zavers_consumer/zavers_save_it_anim.gif</save_button_animation_url>
    <categories>
    <category>Beer/Malt Beverages</category>
    </categories>
    </offer>
    </catalog>
  STRING
end

def error_response!
  <<-STRING
    <?xml version='1.0' encoding='utf-8' ?>
    <errors count='1'>
    <error>
    <code>400</code>
    <type>Invalid Consumer ID</type>
    <message>The Consumer ID that was provided could not be matched to a Consumer.</message>
    </error>
    </errors>
  STRING
end

def consumer_response!
  <<-STRING
    <?xml version='1.0' encoding='utf-8' ?>
    <consumer>
    <consumer_id>962</consumer_id>
    <id_value>ebudd@zavers.com</id_value>
    <zip_code>66103</zip_code>
    <status>Active</status>
    <household_id>962</household_id>
    <first_name>Eric</first_name>
    <last_name>Budd</last_name>
    <account_news>true</account_news>
    <program_news>false</program_news>
    <opt_in_mobile_text>false</opt_in_mobile_text>
    <address_1>4567 2nd Ave</address_1>
    <address_2></address_2>
    <city>Overland Park</city>
    <state>KS</state>
    <home_number></home_number>
    <savings_last_visit>0</savings_last_visit>
    <savings_in_account>300</savings_in_account>
    <segment></segment>
    <identifiers count='3'>
    <email id='1174'>ebudd@zavers.com</email>
    <loyalty_card id='2291' retailer_id='7'>40018888887</loyalty_card>
    <loyalty_card id='2625' retailer_id='3'>400188888887</loyalty_card>
    </identifiers>
    </consumer>
  STRING
end

def updated_consumer_response!
  <<-STRING
    <?xml version='1.0' encoding='utf-8' ?>
    <consumer>
    <consumer_id>962</consumer_id>
    <id_value>ebudd@zavers.com</id_value>
    <zip_code>66062</zip_code>
    <status>Active</status>
    <household_id>962</household_id>
    <first_name>Joe</first_name>
    <last_name>Cool</last_name>
    <account_news>true</account_news>
    <program_news>false</program_news>
    <opt_in_mobile_text>false</opt_in_mobile_text>
    <address_1>123 Test</address_1>
    <address_2>Apt C</address_2>
    <city>Olathe</city>
    <state>KS</state>
    <home_number></home_number>
    <savings_last_visit>0</savings_last_visit>
    <savings_in_account>300</savings_in_account>
    <segment></segment>
    <identifiers count='3'>
    <email id='1174'>ebudd@zavers.com</email>
    <loyalty_card id='2291' retailer_id='7'>40018888887</loyalty_card>
    <loyalty_card id='2625' retailer_id='3'>400188888887</loyalty_card>
    </identifiers>
    </consumer>
  STRING
end

def offer_event!
  <<-STRING
    <?xml version="1.0" encoding="UTF-8"?>
    <state_change>
      <consumer_id>123456</consumer_id>
      <coupon_id>54321</coupon_id>
      <event>select</event>
      <event_instances>1</event_instances>
      <state>saved</state>
    </state_change>
STRING
end
