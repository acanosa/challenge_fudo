require "rack/static"
require_relative "products/products_controller"
require_relative "authentication/login_controller"

use Rack::Static, :urls => {"/openapi" => "openapi.yaml", "/authors" => "AUTHORS.md"}, :root =>".", :header_rules => [
    [%w(yaml), {
      "cache-control" => "no-store, no-cache, must-revalidate, max-age=0",
      "pragma" => "no-cache",
      "expires" => "0"
    }],
    [%w(md), {
       'cache-control' => 'public, max-age=86400',
       'content-type' => 'text/markdown'
    }]
  ]

app = Rack::URLMap.new "/products" => Products.new, "/login" => LoginController.new

run app
