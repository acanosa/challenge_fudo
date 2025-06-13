require "rack/static"
require "rack/deflater"
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

use Rack::Deflater, if: ->(env, status, headers, body) {
  env['HTTP_ACCEPT_ENCODING'].to_s.include?('gzip')
}

app = Rack::URLMap.new "/products" => Products.new, "/login" => LoginController.new

run app
