
class Product
  attr_accessor :id, :name

  def initialize(id, name)
    @id = id
    @name = name
  end
end

class ProductRepository
  attr_accessor :products

  def initialize()
    @products = [Product.new(1, "Coca-Cola"), Product.new(2, "Pepsi"), Product.new(3, "7-Up"), Product.new(4, "Sprite")]
  end

  def findAll()
    return @products
  end
end


class Products
  def initialize()
    @productRepository = ProductRepository.new()
  end

  def call(env)
    products = @productRepository.findAll
    body= products.map { |product| "#{product.id} - #{product.name}"}.join("<br/>")
    [200, {"content-type" => "text/html"}, [body]]
  end
end
