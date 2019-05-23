class CreateShopifyCustomers < ActiveRecord::Migration[5.0]
  def change
    create_table :shopify_customers do |t|
      t.integer :shopify_id
      t.string :email
      t.string :first_name
      t.string :last_name
      t.integer :orders_count
      t.float :total_spent
      t.integer :last_order_id
      t.boolean :verified_email
      t.string :phone
      t.string :tags
      t.string :currency

      t.timestamps
    end
  end
end
