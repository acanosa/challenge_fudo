require 'jwt'
require 'json'
require_relative 'product_repository'
require_relative '../authentication/authentication_service'
require_relative 'product_service'

class Products
  def initialize()
    @product_repository = ProductRepository.instance
    @authentication_service = AuthenticationService.new()
    @product_service = ProductService.new()
  end

  def call(env)
    begin
      if !@authentication_service.is_valid_token?(env["HTTP_AUTHORIZATION"])
        return [401, {"content-type" => "text/html"}, ["Invalid or missing token"]]
      end
    rescue JWT::VerificationError => exception
      puts exception
      return [401, {"content-type" => "text/html"}, ["Invalid or missing token"]] 
    end

    request = Rack::Request.new(env)
    case request.request_method
      when "GET"
        products = @product_repository.find_all
        body= products.map { |product| "#{product.id} - #{product.name}"}.join("<br/>")
        [200, {"content-type" => "text/html"}, [body]]
      when "POST"
        if request.body.nil?
          [400, {"content-type" => "text/html"}, ["Body with product information is mandatory"]]
        end
        body = JSON.parse(request.body.read)
        
        Thread.new do
          sleep 5
          @product_service.create_product(body["name"])
        end 

        [202, {"content-type" => "text/html"}, ["Started processing..."]]
      else
        [405, {}, ["METHOD NOT ALLOWED: #{request.request_method}"]]
    end
  end
end
