require 'rubygems'
require 'nokogiri'

class Consumer

  attr_accessor :consumer_id, :email, :mobile, :loyalty_cards,  :zip_code, :status, :household_id,
    :first_name, :last_name, :account_news, :program_news, :opt_in_mobile_text,
    :address_1, :address_2, :city, :state, :home_number, :savings_last_visit,
    :savings_in_account, :segment, :identifiers, :password

  def initialize(attributes={})
    @consumer_id        =  attributes[:consumer_id]
    @email              =  attributes[:email]
    @mobile             =  attributes[:mobile]
    @zip_code           =  attributes[:zip_code]
    @status             =  attributes[:status]
    @household_id       =  attributes[:household_id]
    @first_name         =  attributes[:first_name]
    @last_name          =  attributes[:last_name]
    @account_news       =  attributes[:account_news]
    @program_news       =  attributes[:program_news]
    @opt_in_mobile_text =  attributes[:opt_in_mobile_text]
    @address_1          =  attributes[:address_1]
    @address_2          =  attributes[:address_2]
    @city               =  attributes[:city]
    @state              =  attributes[:state]
    @home_number        =  attributes[:home_number]
    @savings_last_visit =  attributes[:savings_last_visit]
    @savings_in_account =  attributes[:savings_in_account]
    @segment            =  attributes[:segment]
    @loyalty_cards      =  attributes[:loyalty_cards] || []
    @password           =  attributes[:password]
  end

  def self.parse(xml)
    doc = Nokogiri::XML(xml)
    consumer = doc.css("consumer").map do |item|
      Consumer.from_xml(item)
    end.first
  end

  def self.from_xml(xml)
    identifiers = []
     xml.css("loyalty_card").map do |item|
      if item
        identifiers << Identifier.new(:type => "loyalty_card", :value => item.text, :id => item["id"], :retailer_id => item["retailer_id"])
      end
    end

    new(
      :consumer_id        =>  xml.css("consumer_id").text,
      :email              =>  Identifier.from_email(xml.css("email").first),
      :mobile             =>  Identifier.from_mobile(xml.css("mobile_number").first),
      :zip_code           =>  xml.css("zip_code").text,
      :status             =>  xml.css("status").text,
      :household_id       =>  xml.css("household_id").text,
      :first_name         =>  xml.css("first_name").text,
      :last_name          =>  xml.css("last_name").text,
      :account_news       =>  xml.css("account_news").text,
      :program_news       =>  xml.css("program_news").text,
      :opt_in_mobile_text =>  xml.css("opt_in_mobile_text").text,
      :address_1          =>  xml.css("address_1").text,
      :address_2          =>  xml.css("address_2").text,
      :city               =>  xml.css("city").text,
      :state              =>  xml.css("state").text,
      :home_number        =>  xml.css("home_number").text,
      :savings_last_visit =>  xml.css("savings_last_visit").text,
      :savings_in_account =>  xml.css("savings_in_account").text,
      :segment            =>  xml.css("segment").text,
      :loyalty_cards      => identifiers
    )
  end
  def to_local
    LocalConsumer.new(self.to_hash)
  end

  def to_hash
    {
      :first_name         =>  first_name,
      :last_name          =>  last_name,
      :address_1          =>  address_1,
      :address_2          =>  address_2,
      :city               =>  city,
      :state              =>  state,
      :zip_code           =>  zip_code,
      :home_number        =>  home_number,
      :status             =>  status,
      :account_news       =>  account_news,
      :program_news       =>  program_news,
      :opt_in_mobile_text =>  opt_in_mobile_text,
      :email              =>  email,
      :mobile             =>  mobile,
      :loyalty_cards      =>  loyalty_cards
    }
  end
end

