class User < ActiveRecord::Base
  has_many :user_stocks

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  # def create
  #   @user = User.new(params[:user])
  #   @user.password = params[:password]
  #   @user.save!
  # end

end

