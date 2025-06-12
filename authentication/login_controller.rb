require_relative 'user_service'

class LoginController
  def initialize()
    @user_service = UserService.new()
  end
  
  def call(env)
    user_service.f
  end


end
require_relative 'product_repository'

class Products
  def initialize()
    @product_repository = ProductRepository.new()
  end

  def call(env)
    products = @product_repository.find_all
    body= products.map { |product| "#{product.id} - #{product.name}"}.join("<br/>")
    [200, {"content-type" => "text/html"}, [body]]
  end
end
