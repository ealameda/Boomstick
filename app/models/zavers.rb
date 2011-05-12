class Zavers < MonsterMash::Base
  defaults do
    user_agent "Zavers Reference Agent"
    username 11111
    password 22222
  end

  get(:brand_offers) do |options|
    uri "http://expo.zavers.com/api/brand_offers.xml"
    params options
    handler {|response| OffersList.parse(response.body)}
  end

  post(:consumer_create) do |options|
    # need to make this cleaner for input parameters
    uri "http://expo.zavers.com/api/consumer.xml"
    params  :type_id => "email",
            :id_value => options[:email],
            :password => options[:password],
            :zip_code => options[:zip_code]
    handler {|response| Consumer.parse(response.body)}
  end

  get(:consumer_read) do |options|
    uri "http://expo.zavers.com/api/consumer.xml"
    params   :type_id => "email",
             :id_value => options[:id_value]
    handler {|response| Consumer.parse(response.body)}
  end

  post(:consumer_update) do |options|
    # need to make this cleaner for input parameters
    uri "http://expo.zavers.com/api/consumer/#{options[:consumer_id]}.xml"
    params  :first_name         => options[:first_name],
            :last_name          => options[:last_name],
            :address_1          => options[:address_1],
            :address_2          => options[:address_2],
            :city               => options[:city],
            :state              => options[:state],
            :zip_code           => options[:zip_code],
            :home_number        => options[:home_number],
            :account_news       => options[:account_news],
            :program_news       => options[:program_news],
            :opt_in_mobile_text => options[:opt_in_mobile_text]
    handler {|response| Consumer.parse(response.body)}
  end

  post(:consumer_authenticate) do |options|
    uri "http://expo.zavers.com/api/consumer/authenticate.xml"
    params  :type_id => options[:type_id],
            :id_value => options[:id_value],
            :password => options[:password]
    handler {|response| Consumer.parse(response.body)}
  end

  get(:offers) do |options|
    uri "http://expo.zavers.com/api/consumer/#{options[:consumer_id]}/offers.xml"
    params options
    handler {|response| OffersList.parse(response.body)}
  end

  post(:offer_event) do |options|
    uri "http://expo.zavers.com/api/consumer/#{options[:consumer_id]}/coupon/#{options[:coupon_id]}.xml"
    params options
    handler {|response| OfferEvent.parse(response.body)}
  end

  get(:retailers) do |options|
    uri "http://expo.zavers.com/api/consumer/#{options[:consumer_id]}/retailer.xml"
    params options
    handler {|response| puts response.body}
  end

















  # get(:retailers)
    # /api/consumer/[consumer_id]/retailers.xml
    # /api/retailers/[zip_code].xml

  # get(:manufacturers)
    # /api/consumer/[consumer_id]/manufacturers.xml
    # /api/manufacturers/[zip_code].xml


  # post(:offers_media)
    # /api/campaigns/media_catalog.xml

  # post(:offer_event)
    # /api/consumer/[consumer_id]/coupon/[coupon_id].xml


  # post(:reset_password)
    # /api/consumer/reset_password.xml

  # post(:resend_activation)
    # /api/consumer/resend_activation.xml

  # get(:consumer_household)

  # post(:add_identifier)
    # /api/consumer/[consumer_id]/identifiers.xml

  # post(:update_identifier)
    # /api/consumer/[consumer_id]/identifiers/[identifier_id].xml

  # post(:remove_identifier)
    # /api/consumer/[consumer_id]/identifiers/[identifier_id]/remove.xml

end

module MonsterMash
  class Base
    def self.check_response_and_raise!(response)
      code = response.code.to_i
      if code < 200 or code >= 400
       error = ZaversError.parse(response.body)
       raise error
      end
    end
  end
end

