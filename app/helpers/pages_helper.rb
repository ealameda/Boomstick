module PagesHelper
  def pagination_helper(page)
    page = normalize_page_number(page)
    html = []
    html << link_to("Prev Page", "?page=#{page.to_i - 1}") if page.to_i > 1
    html << link_to("Next Page", "?page=#{page.to_i + 1}") if @offers.total_count.to_i > 10 * page.to_i
    html.join(' &gt; ').html_safe
  end
end

