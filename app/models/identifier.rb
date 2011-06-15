class Identifier
  attr_reader :type, :id, :value, :retailer_id

  def initialize(attributes)
    @type        =  attributes[:type]
    @id          =  attributes[:id]
    @value       =  attributes[:value]
    @retailer_id =  attributes[:retailer_id]
  end

  def to_s
    self.value
  end

  def self.from_email(email)
    new(:type => "email", :value => email.text, :id => email["id"]) if email
  end

  def self.from_mobile(mobile)
    self.new(:type => "mobile", :value => mobile.text, :id => mobile["id"]) if mobile
  end

  def self.from_xml(type, xml)
    new(
      :type         =>  type,
      :id           =>  xml.css("id").first["id"],
      :value        =>  xml.css("value").text,
      :retailer_id  =>  xml.css("retailer_id").text
    )
  end
end
