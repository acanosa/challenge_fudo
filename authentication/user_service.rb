require 'jwt'
require 'bcrypt'
require_relative 'user_repository'
require_relative 'authentication_service'
require_relative 'user'
require_relative '../exception/user_not_found_exception'

class UserService

  def initialize()
    @user_repository = UserRepository.new()
    @authentication_service = AuthenticationService.new()
  end

  #Password must be encrypted first TODO is it ok to rely in the method caller? 
  def findByUsernameAndPassword(username, password)
    user_exists = @user_repository.existsByUsernameAndPassword(username, password)
      
    if user_exists
      user = @user_repository.findByUsernameAndPassword(username, password)
    else
      raise UserNotFoundException.new()
    end

  end

end

