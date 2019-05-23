module Shopify
  class AfterAuthenticateJob < ActiveJob::Base
    def perform(shop_domain:)
      shop = Shop.find_by(shopify_domain: shop_domain)
      shop.with_shopify_session do
        total_customers = ShopifyAPI::Customer.count


        if shop.shopify_customers.count < total_customers


        end
        shopify_customers = ShopifyAPI::Customer.find(:all)

        unless shopify_customers.nil?
          shopify_customers.each do |c|
            customers = get_customers(shop)


            customers.each do |c|
                customer = shop.shopify_customers.new
                customer.shopify_id = c.id
                customer.email = c.email
                customer.first_name = c.first_name
                customer.last_name = c.last_name
                customer.orders_count = c.orders_count
                # TODO - convert total spent from string to float
                customer.last_order_id = c.last_order_id
                customer.verified_email = c.verified_email
                customer.phone = c.phone
                customer.tags = c.tags
                customer.currency = c.currency

                customer.save!

            end
          end
        end
      end
    end


    def get_customers(shop)

      page = 1
      customers = []
      shopify_customer_count = shop.shopify_customers.count
      count = ShopifyAPI::Customer.count
      puts "currently have #{shopify_customer_count} of #{count} Customers"
      if count > 0 and count > shopify_customer_count
        page += count.divmod(250).first
        while page > 0
          puts "Processing page #{page}"
          customers += ShopifyAPI::Customer.all(:params => {:page => page, :limit => 250})
          page -= 1
        end
      else
        puts 'already have all customers'
      end
      puts "Returning #{customers.length} of #{shopify_customer_count}"
      customers
    end
  end
end
