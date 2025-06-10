require_relative "products/products"
require_relative "authors/authors"

defaultRegex = Regexp.new("")

app = Rack::URLMap.new "/products" => Products.new, "/authors" => Authors.new("./authors/AUTHORS.md")

run app
  #require_relative "app"


#run HelloWorld.new
