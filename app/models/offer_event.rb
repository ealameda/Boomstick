class OfferEvent
  attr_reader :consumer_id, :coupon_id, :event, :event_instances, :state

  def initialize(attributes={})
    @consumer_id = attributes[:consumer_id]
    @coupon_id = attributes[:coupon_id]
    @event = attributes[:event]
    @event_instances = attributes[:event_instances]
    @state = attributes[:state]
  end

  def self.from_xml(xml)
    new(
      :consumer_id => xml.css("consumer_id").text,
      :coupon_id => xml.css("coupon_id").text,
      :event => xml.css("event").text,
      :event_instances => xml.css("event_instances").text,
      :state => xml.css("state").text
    )
  end

  def self.parse(xml)
    doc = Nokogiri::XML(xml)
    offer_event = doc.css("state_change").map do |item|
      OfferEvent.from_xml(item)
    end.first
  end
end

