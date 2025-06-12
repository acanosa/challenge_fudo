class UserNotFoundException < StandardError
  def initialize(message = "User not found")
    super
  end
end
