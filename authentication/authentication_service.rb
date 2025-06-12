require 'jwt'
require 'bcrypt'
require_relative 'user_service'

class AuthenticationService

  def initialize()
    @rsa_private_key = OpenSSL::PKey::RSA.generate(2048)
    @rsa_public_key = @rsa_private_key.public_key
    @user_service = UserService.new() 
  end

  def authenticate(username, password)
      password = encrypt(password)
      user = @user_service.findByUsernameAndPassword(username, password)
      generateToken(user)
  end

  def decodeToken(token)
    begin 
      JWT.decode(token, @rsa_public_key, true,  {algorithm: 'RS256'})
    rescue StandardError => exception
      puts "Error decoding JWT token #{exception.message}"
    end
  end

  private 

  def encrypt(password)
    begin
      BCrypt::Password.create(password)
    rescue StandardError => exception
      puts "Unexpected error while encrypting password"
      raise "Unexpected error while processing authentication"
    end
  end

  def generateToken(user)
    payload = {user_id: user.id, user_name: user.username, exp: Time.now.to_i + 3600}
    JWT.encode(payload, @rsa_private_key, 'RS256')
  end

end

