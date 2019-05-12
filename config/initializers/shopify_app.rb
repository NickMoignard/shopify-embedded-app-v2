ShopifyApp.configure do |config|
  config.application_name = "My Shopify App"
  config.api_key = ENV['SHOPIFY_API_KEY']
  config.secret = ENV['SHOPIFY_API_SECRET']

  config.scope = "read_products, read_customers" # Consult this page for more scope options:
                                 # https://help.shopify.com/en/api/getting-started/authentication/oauth/scopes
  config.embedded_app = true
  config.session_repository = Shop
  config.after_authenticate_job = { job: Shopify::AfterAuthenticateJob, inline: false }
end
