class ZaversError < StandardError
  attr_reader :code, :type, :message

  def initialize(attributes={})
    @code     =  attributes[:code] || "500"
    @type     =  attributes[:type] || "Unknown Error" 
    @message  =  attributes[:message] || "We're sorry, but something went wrong. We've been notified about this issue and we'll take a look at it shortly."
  end

  def self.from_xml(xml)
    new(:code     =>  xml.css("code").text,
        :type     =>  xml.css("type").text,
        :message  =>  xml.css("message").text)
  end

  def self.parse(xml)
    doc = Nokogiri::XML(xml).css("error")
    if doc && doc.any?
      ZaversError.from_xml(doc.first)
    else
      ZaversError.new
    end
  end
end
