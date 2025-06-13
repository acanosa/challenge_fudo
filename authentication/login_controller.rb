require 'json'
require_relative 'authentication_service'

class LoginController
  def initialize()
    @authentication_service = AuthenticationService.new()
  end
  
  def call(env)
    request = Rack::Request.new(env)
    body = JSON.parse(request.body.read)

    case request.request_method
      when "POST"

        [200, {"content-type" => "application/json"}, [{token: @authentication_service.authenticate(body["username"], body["password"])}.to_json]]
      else
        [405, {"content-type" => "application/json"}, [{status: 405, message: "METHOD NOT ALLOWED: #{request.request_method}"}.to_json]]
    end
  end

end
