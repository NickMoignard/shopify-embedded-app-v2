class AddShopReferencesToShopifyCustomer < ActiveRecord::Migration[5.0]
  def change
    add_reference :shopify_customers, :shop, foreign_key: true
  end
end
