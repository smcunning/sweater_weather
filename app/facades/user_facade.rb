class UserFacade
  def self.create_user(request)
    user_data = parse(request)
    user = User.create({
      email: user_data[:email],
      password: user_data[:password],
      password_confirmation: user_data[:password_confirmation],
      })
    UserSerializer.new(user)
  end

  def self.parse(request)
    JSON.parse(request, symbolize_names: true)
  end
end
