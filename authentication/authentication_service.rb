require 'jwt'
require 'bcrypt'
require_relative 'user_service'

KEYPAIR = OpenSSL::PKey::RSA.generate(2048)
class AuthenticationService

  def initialize()
    @rsa_private_key = KEYPAIR
    @rsa_public_key = KEYPAIR.public_key
    @user_service = UserService.new() 
  end

  def authenticate(username, password)
      user = @user_service.find_by_username_and_password(username, password)
      generate_token(user)
  end

  def is_valid_token?(token)
    return false if token.nil?

    match = token.match(/Bearer\s+(.*)$/)
    return false unless match

    token = match[1]

    token = decode_token(token)
    return false unless token

    payload = token[0]
    @user_service.exists_by_username?(payload["user_name"])
  
  end

  def decode_token(token)
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

  def generate_token(user)
    payload = {user_id: user.id, user_name: user.username, exp: Time.now.to_i + 3600}
    JWT.encode(payload, @rsa_private_key, 'RS256')
  end

end

