# frozen_string_literal: true

class HomeController < AuthenticatedController
  def index
    shopify_shop = ShopifyAPI::Shop.current
    @shop = Shop.find_by(:shopify_domain => shopify_shop.domain)
    @customers = @shop.shopify_customers

    respond_to do |format|
      format.html
      format.csv { send_data  @customers.to_csv, :filename => "#{Date.today}-Customers.csv" }
    end
  end

  def export
    shopify_shop = ShopifyAPI::Shop.current
    @shop = Shop.find_by(:shopify_domain => shopify_shop.domain)
    @customers = @shop.shopify_customers

    respond_to do |format|
      format.html
      format.csv { send_data  @customers.to_csv, :filename => "#{Date.today}-Customers.csv" }
    end
  end
end
