class ZaversError < StandardError
require 'rubygems'
require 'nokogiri'

  attr_reader :code, :type, :message

  def initialize(attributes)
    @code     =  attributes[:code] || "500"
    @type     =  attributes[:type] || "Unknown Error" 
    @message  =  attributes[:message] || "We're sorry, but something went wrong. We've been notified about this issue and we'll take a look at it shortly."
  end

  def self.from_xml(xml)
    new(
      :code     =>  xml.css("code").text,
      :type     =>  xml.css("type").text,
      :message  =>  xml.css("message").text
    )
  end

  def self.parse(xml)
    doc = Nokogiri::XML(xml).css("error")
    if doc && doc.any?
      doc.map do |item|
        ZaversError.from_xml(item)
      end.first
    else
      ZaversError.new(:code => "500", :type => "Unknown Error",
        :message => "We're sorry, but something went wrong. We've been notified about this issue and we'll take a look at it shortly.")
    end
  end
end

