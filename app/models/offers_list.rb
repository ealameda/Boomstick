class OffersList
  attr_reader :offers, :total_count, :consumer_id

  def initialize(consumer_id, total_count, offers)
    @consumer_id = consumer_id
    @total_count = total_count
    @offers = offers || []
  end

  def self.parse(xml)
    doc = Nokogiri::XML(xml)
    consumer_id = doc.css("consumer_id").text
    total_count = doc.css("offers").first["total_count"]
    offers = doc.css("offer").map do |item|
      Offer.from_xml(item)
    end

    new(consumer_id, total_count, offers)
  end

  def coupon_ids
    @coupon_ids ||= self.offers.map {|offer| offer.coupon_id if offer.coupon_id.present?}.compact
  end
end

class Offer
  attr_reader :coupon_id, :campaign_id, :company_id, :company_name, 
    :campaign_start_date, :campaign_end_date, :coupon_state, :display_name,
    :learn_more_text, :short_description, :long_description, :offer_summary,
    :terms_and_conditions, :offer_id, :image_url, :learn_more_image_url,
    :learn_more_image_alt_text, :video_url, :audio_url

  def initialize(attributes)
    @coupon_id                 = attributes[:coupon_id]
    @campaign_id               = attributes[:campaign_id]
    @company_id                = attributes[:company_id]
    @company_name              = attributes[:company_name]
    @campaign_start_date       = attributes[:campaign_start_date]
    @campaign_end_date         = attributes[:campaign_end_date]
    @coupon_state              = attributes[:coupon_state]
    @display_name              = attributes[:display_name]
    @learn_more_text           = attributes[:learn_more_text]
    @short_description         = attributes[:short_description]
    @long_description          = attributes[:long_description]
    @offer_summary             = attributes[:offer_summary]
    @terms_and_conditions      = attributes[:terms_and_conditions]
    @offer_id                  = attributes[:offer_id]
    @image_url                 = attributes[:image_url]
    @learn_more_image_url      = attributes[:learn_more_image_url]
    @learn_more_image_alt_text = attributes[:learn_more_image_alt_text]
    @video_url                 = attributes[:video_url]
    @audio_url                 = attributes[:audio_url]
  end

  def self.from_xml(xml)
    new(
      :coupon_id                 =>  xml.css("coupon_id").text,
      :campaign_id               =>  xml.css("campaign_id").text,
      :company_id                =>  xml.css("company_id").text,
      :company_name              =>  xml.css("company_name").text,
      :campaign_start_date       =>  xml.css("campaign_start_date").text,
      :campaign_end_date         =>  xml.css("campaign_end_date").text,
      :coupon_state              =>  xml.css("coupon_state").text,
      :display_name              =>  xml.css("display_name").text,
      :learn_more_text           =>  xml.css("learn_more_text").text,
      :short_description         =>  xml.css("short_description").text,
      :long_description          =>  xml.css("long_description").text,
      :offer_summary             =>  xml.css("offer_summary").text,
      :terms_and_conditions      =>  xml.css("terms_and_conditions").text,
      :offer_id                  =>  xml.css("offer_id").text,
      :image_url                 =>  xml.css("image_url").text,
      :learn_more_image_url      =>  xml.css("learn_more_image_url").text,
      :learn_more_image_alt_text =>  xml.css("learn_more_image_alt_text").text,
      :video_url                 =>  xml.css("video_url").text,
      :audio_url                 =>  xml.css("audio_url").text
    )
  end
end
