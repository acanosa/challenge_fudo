require_relative 'product'

class ProductRepository
  attr_accessor :products

  def initialize()
    @products = [Product.new(1, "Coca-Cola"), Product.new(2, "Pepsi"), Product.new(3, "7-Up"), Product.new(4, "Sprite")]
  end

  def find_all()
    return @products
  end
end

