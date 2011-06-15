class LocalConsumer
  include ActiveModel::Conversion
  extend  ActiveModel::Naming
  include ActiveModel::Validations
  attr_accessor :consumer_id, :email, :mobile, :loyalty_cards,  :zip_code, :status, :household_id, :first_name, :last_name, :account_news, :program_news, :opt_in_mobile_text, :address_1, :address_2, :city, :state, :home_number, :savings_last_visit, :savings_in_account, :segment, :identifiers, :password

    validates_format_of   :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
    validates_length_of   :password, :within => 4..40
    validates_presence_of :zip_code

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

  def id
    consumer_id
  end

  def persisted?
    false
  end

  def to_model
    self
  end

  def to_consumer
    Consumer.new(self.to_hash)
  end

  def to_hash
    {
      :consumer_id        =>  consumer_id,
      :first_name         =>  first_name,
      :last_name          =>  last_name,
      :email              =>  email,
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
      :password           =>  password
    }
  end
end
