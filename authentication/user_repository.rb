require_relative 'user'

class UserRepository

  def initialize()
    @users = [User.new(1, "testUser", "$2a$16$FeN0o6ovUhljiq5orhrMdeFBh/58bzBGWxCH7D7vhau8TVIPZRSpW"), User.new(2, "testUser2", "$2a$16$cI/oQHGF.48SAfM4svoK8OBgXnvMBHdF1xhG3QJrlWeGA1IJkY8Yq")]
  end

  def existsByUsernameAndPassword(username, password)
    @users.any? {|user| user.username == username && user.password == password}
  end

  def findByUserNameAndPassword(username, password)
    @users.find( {|user| user.username == username && user.password == password})
  end

end
