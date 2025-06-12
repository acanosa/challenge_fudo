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

        [200, {"content-type" => "text/plain"}, [@authentication_service.authenticate(body["username"], body["password"])]]
      else
        [405, {}, ["METHOD NOT ALLOWED: #{request.request_method}"]]
    end
  end

end
