class ChangeOrderIdIntegerLimitInShopifyCustomers < ActiveRecord::Migration[5.0]
  def change
    change_column :shopify_customers, :last_order_id, :integer, limit: 8
  end
end
