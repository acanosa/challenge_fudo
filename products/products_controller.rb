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
        return [401, {"content-type" => "application/json"}, [{status: 401, message: "Invalid or missing token"}.to_json]]
      end
    rescue JWT::VerificationError => exception
      puts exception
      return [401, {"content-type" => "application/json"}, [{status: 401, message: "Invalid or missing token"}.to_jsonn]] 
    end

    request = Rack::Request.new(env)
    case request.request_method
      when "GET"
        products = @product_repository.find_all
        response = products.map {|product| {id: product.id, name: product.name}}
        [200, {"content-type" => "application/json"}, [response.to_json()]]
      when "POST"
        if request.body.nil?
          [400, {"content-type" => "application/json"}, [{status: 400, message: "Body with product information is mandatory"}.to_json]]
        end
        body = JSON.parse(request.body.read)
        
        Thread.new do
          sleep 5
          @product_service.create_product(body["name"])
        end 

        [202, {"content-type" => "application/json"}, [{message: "Started processing..."}.to_json]]
      else
        [405, {"content-type" => "application/json"}, [{status: 405, message: "METHOD NOT ALLOWED: #{request.request_method}"}.to_json]]
    end
  end
end
