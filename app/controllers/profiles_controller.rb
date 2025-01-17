class ProfilesController < ApplicationController
  def show
    # Fetch the profile using `find_by` to avoid raising an exception if not found
    @profile = Profile.find_by(username: params[:username])
    
    if @profile
      render json: { message: 'Profile found', profile: @profile }, status: :ok
    else
      render json: { message: 'Profile not found' }, status: :not_found
    end
  rescue => e
    render json: { message: 'An error occurred', error: e.message }, status: :unprocessable_entity
  end

  def create
    @profile = Profile.new(profile_params)
    if @profile.save
      render json: @profile, status: :created
    else
      render json: @profile.errors, status: :unprocessable_entity
    end
  end

  def update
    puts "hello coming incoming babe"
    puts "params here are #{params[:profile][:profileImage][0]}"
    puts "params here are #{params[:profile][:profileImage].class}"
    @profile = Profile.find_by(username: params[:username])
    if @profile.update_attributes(username: params[:profile][:username], bio: params[:profile][:bio], title: params[:profile][:title], profileImage: params[:profile][:profileImage][0])
      render json: { message: 'Profile updated successfully', profile: @profile }, status: :ok
    else
      render json: { error: 'Failed to update profile', details: @profile.errors.full_messages }, status: :unprocessable_entity
    end
  end
    private

    def profile_params
        params.require(:profile).permit(:username, :title, :bio, :profileImage)
    end
end