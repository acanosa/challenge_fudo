require_relative 'product_repository'
require_relative 'product'

class ProductService

  def initialize()
    @product_repository = ProductRepository.instance
  end

  def create_product(name)
    if name.nil?
      puts "Failed to create product: attribute 'name' is mandatory"
      return [400, {"content-type" => "text/html"}, ["Attribute 'name' is mandatory"]]
    end

    if @product_repository.exists_by_name?(name)
      puts "Product with name #{name} already exists"
      return [400, {"content-type" => "text/html"}, ["Product with name #{name} already exists"]]
    end

    @product_repository.save(name)
    puts "Saved product #{name}"

  end

end


