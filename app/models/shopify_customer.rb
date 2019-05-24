class ShopifyCustomer < ApplicationRecord
  belongs_to :shop

  def self.to_csv
    # TODO automatically determine headers with Model.first.attributes.keys
    #   add csv extension to Models with csv export
    attributes =  ["id", "shopify_id", "email", "first_name", "last_name", "orders_count", "total_spent", "last_order_id", "verified_email", "phone", "tags", "currency", "created_at", "updated_at", "shop_id"]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |customer|
        csv << attributes.map{ |attr| customer.send(attr) }
      end
    end
  end
end
