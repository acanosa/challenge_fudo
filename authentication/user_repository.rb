require_relative 'user'

class UserRepository

  def initialize()
    @users = [User.new(1, "testUser", "$2a$12$kNeWLZ61tyPVGDbz4FntI.fhzUZYM3vGlI3pChadq648wYRhtnFR2"), User.new(2, "testUser2", "$2a$12$B/2GWzDcmHTR4Lj0v2mgeO8L5irUBPHAKLuLa5taX94Oj8E/co.FG")]
  end

  def exists_by_username(username)
    @users.any? {|user| user.username == username}
  end

  def find_by_username(username)
    @users.find {|user| user.username == username }
  end

end
