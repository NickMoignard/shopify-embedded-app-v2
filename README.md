# README
Ruby version - 2.3.1
Rails - 5.0.7

 Prerequisites: git, rbenv, terraform, awscli, ruby (with credentials in PATH & .pem file setup)
    Use your software package manager of choice and install on which ever system is running the server
    Operational Shopify Partner Development store to test application
 
 * Download, Install App & Gems then run generators and db:migrations
 >```
 >$ git clone https://github.com/NickMoignard/shopify_embedded_app.git;
 >$ cd /path/to/shopify_embedded_app;
 >$ bundle update;
 >$ bundle;
 >$ rails webpacker:install
 >$ rails webpacker:install:react
 >$ rails generate:install:react
 >$ rails generate shopify_app:install
 >$ rails generate shopify_app:shop_model
 >$ rails generate shopify_app:home_controller
 >$ rails db:create
 >$ rails db:migrate
 >```
 
 
 * Test DB & Rails Server
 > If you can connect to the shop model. db is all set up :)
 >```
 >$ rails c
 >irb(main):002:0> Shop.connection
 >```
 >test the server works and go to localhost:3000
 >
 >```$ rails s```

 * Add your Shopify Credentials to Environment
>```
>/.env
>SHOPIFY_API_KEY=<your api key>
>SHOPIFY_API_SECRET=<your api secret>
>```

* Install Base App on Development Store 
>From the Partner Dashboard click test application and try installing on one of your personal development stores.
>You will most likely have to do a bit of debugging with your servers or permissions to get this going. Just google the error codes.  
> 
>    Common Errors
>    - AWS security groups not having correct permissions and
>    - API Credentials not correctly loaded as environment variables

# Deployment
* Terraform - AWS
> 0. Click this https://www.terraform.io/docs/providers/aws/index.html and ensure you get understand how terraform works. It will result in your AWS account being charged
> (if free tier not specified) 
> 2. Setup AWSKeyPair.pem and download onto local machine.
> 3. Check that `awscli` is installed.  
> 4. Ensure AWS credentials are Environment Variables in your PATH.
> 4.  ```
>    $ export AWS_ACCESS_KEY_ID="anaccesskey"
>    $ export AWS_SECRET_ACCESS_KEY="asecretkey"
>    $ export AWS_DEFAULT_REGION="us-west-2"
>    ```
> 5. Alter the terraform configuration file `Main.tf` to your liking
> 
>   You should think deeply about your main.tf file and the requirments you need for your application
> 6. 
> 6. ```
>    $ terraform plan
>    $ terraform apply
>   ```
>
> NOTE: use `$ terraform destroy` to remove unwanted resource instances 





# TBA
* How to run the test suite
    tba

* Services (job queues, cache servers, search engines, etc.)

