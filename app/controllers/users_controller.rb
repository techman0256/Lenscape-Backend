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

  def suggestions
    # Fetch all users from MongoDB and filter those who are not followed by the current user
    @profile = Profile.all.map do |user|
      {
        username: user.username,
        profileImage: user.profileImage
      }
    end
    current_user = Profile.find_by(username: params[:username])
    puts "#{current_user.follows}"

    current_user_following = current_user.follows
    suggestion = @profile.reject { |user| current_user_following.include?(user[:username]) }

    render json: { profile: suggestion }
  end

  def follows
    user_to_follow_username = params[:follows]
    
    if user_to_follow_username
      user_to_follow = Profile.find_by(username: user_to_follow_username)
      current_user_profile = Profile.find_by(username: params[:username])
      
      if user_to_follow && current_user_profile
        # Appending the username to the follows array
        current_user_profile.follows << user_to_follow.username
        current_user_profile.save
        
        render json: { message: 'User followed successfully' }
      else
        render json: { error: 'User not found' }, status: :not_found
      end
    else
      render json: { error: 'No user to follow provided' }, status: :unprocessable_entity
    end
  end

  def unfollows
    user_to_unfollow_username = params[:follows]
    
    if user_to_unfollow_username
      user_to_unfollow = Profile.find_by(username: user_to_unfollow_username)
      current_user_profile = Profile.find_by(username: params[:username])
      
      if user_to_unfollow && current_user_profile
        # Deleting the username from the follows array
        current_user_profile.follows.delete(user_to_unfollow.username)
        current_user_profile.save
        
        render json: { message: 'User unfollowed successfully' }
      else
        render json: { error: 'User not found' }, status: :not_found
      end
    else
      render json: { error: 'No user to unfollow provided' }, status: :unprocessable_entity
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
