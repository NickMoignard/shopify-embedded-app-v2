class Shop < ActiveRecord::Base
  include ShopifyApp::SessionStorage
  has_many :shopify_customers
end
