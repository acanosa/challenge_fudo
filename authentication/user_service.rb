require 'jwt'
require 'bcrypt'
require_relative 'user_repository'
require_relative 'user'
require_relative '../exception/user_not_found_exception'

class UserService

  def initialize()
    @user_repository = UserRepository.new()
  end

  def find_by_username_and_password(username, password)
    user_exists = @user_repository.exists_by_username(username)

    if user_exists
      user = @user_repository.find_by_username(username)
      saved_password = BCrypt::Password.new(user.password)
      if saved_password == password
        user
      else
        raise UserNotFoundException.new("Incorrect username or password")
      end
    else
      raise UserNotFoundException.new("Incorrect username or password")
    end

  end

  def exists_by_username?(username)
    @user_repository.exists_by_username(username)
  end

end

