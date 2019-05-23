class ChangeIntegerLimitInShopifyCustomers < ActiveRecord::Migration[5.0]
  def change
    change_column :shopify_customers, :shopify_id, :integer, limit: 8
  end
end

