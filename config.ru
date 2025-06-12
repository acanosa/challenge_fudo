require "rack/static"
require_relative "products/products_controller"
require_relative "authors/authors"

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

=begin
OPENAPI_ENDPOINT = Rack::Static.new(
  ->(env) {[404, {}, ["File not found!"]]},
 # urls: {"/openapi" => './../openapi.yaml', "/authors" => 'AUTHORS.md'},
  #urls: ['/openapi', '/authors'],
  root: '.',
  header_rules: [
    [['yaml'], {
      "cache-control" => "no-store, no-cache, must-revalidate, max-age=0",
      "pragma" => "no-cache",
      "expires" => "0"
    }],
    [['md'], {
       'cache-control' => 'public, max-age=86400'
    }]
  ]
)
=end 
#app = Rack::URLMap.new "/products" => Products.new, "/authors" => Authors.new("./authors/AUTHORS.md"), "/openapi" => OPENAPI_ENDPOINT 
app = Rack::URLMap.new "/products" => Products.new
#, "/authors" => OPENAPI_ENDPOINT, "/openapi" => OPENAPI_ENDPOINT 


run app
  #require_relative "app"


#run HelloWorld.new
