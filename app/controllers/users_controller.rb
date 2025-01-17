class UsersController < ApplicationController
  def create
    # Parse the JSON object from the request body
    puts "this is user params #{user_params}"
    @user = User.new(user_params)
    # puts "this is user.password #{@user.password}"
    @user.password = encrypt_password(@user.password)
    # puts "this is user.password encrypted #{@user.password}"

    puts BCrypt::Password.new(@user.password) == "password"

    if @user.save
      render json: { message: 'User created successfully', user: @user }, status: :created
    else
      puts @user.errors.full_messages
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  # Strong parameter method for sanitizing input
  def user_params
    puts "logged from user params"
    params.require(:user).permit(:username, :email, :password)
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  # define a methdod to encrypt the password using bcrypt
  def encrypt_password(password)
    puts "This is the password #{password}"
    BCrypt::Password.create(password)
  end
end
