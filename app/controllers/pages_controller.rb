class PagesController < ApplicationController

  def home
    if current_user
      @offers = Zavers.offers(:consumer_id => current_user.consumer_id,
                              :page => normalize_page_number(params[:page]),
                              :per_page => 10,
                              :state => ['new', 'delivered', 'viewed'])
    else
      @offers = Zavers.brand_offers(:page => normalize_page_number(params[:page]),
                                    :per_page => 10)
    end
    flash.now.notice = "There are currently no manufacturer offers available" if @offers.offers.empty?
  end

  def event
    @coupon_id = params[:coupon_id]
    @event = params[:event]
    Zavers.offer_event(:consumer_id => current_user.consumer_id,
                       :coupon_id => @coupon_id,
                       :event => params[:event],
                       :date_time => Time.now.iso8601)
  end

  def retail_offers
    @offers = Zavers.offers(:consumer_id => current_user.consumer_id,
                            :page => normalize_page_number(params[:page]),
                            :per_page => 10,
                            :retailer_id => "ALL",
                            :manufacturer_id => "none")
    flash.now.notice = "There are currently no offers for this retailer" if @offers.offers.empty?
  end

  def saved_offers
    @offers = Zavers.offers(:consumer_id => current_user.consumer_id,
                            :page => normalize_page_number(params[:page]),
                            :per_page => 10,
                            :state => ['saved'],
                            :retailer_id => "ALL")
    flash.now.notice = "You currently don't have any saved offers" if @offers.offers.empty?
  end

  def search_offers
    @offers = Zavers.offers(:consumer_id => current_user.consumer_id,
                            :page => normalize_page_number(params[:page]),
                            :per_page => 10,
                            :search_terms => params[:search],
                            :state => ['new', 'delivered', 'viewed'],
                            :retailer_id => "ALL")
    flash.now.notice = "There are no offers that matched your search" if @offers.offers.empty?
    render :saved_offers
  end













  def hydra_event
    # hydra = Typhoeus::Hydra.new
    # events = Zavers.new(hydra)
    # @offers.coupon_ids.each do |coupon_id|
      # events.offer_event(:consumer_id => current_user.consumer_id, :coupon_id => coupon_id, :event => "deliver", :date_time => "2009-10-14T20:50:00-0600") do |result, error|
        # if error
          # ignore
        # else
          # logger.info(result.to_yaml)
        # end
      # end
    # end
    # hydra.run
  end

end

