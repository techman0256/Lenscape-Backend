class PostsController < ApplicationController
    def create
        # Extract parameters explicitly
        username = params[:username]
        profileImage = params[:profileImage]
        images = params[:images] # Expected to be an array of image URLs
        caption = params[:caption]
    
        # Create a new Post instance
        post = Post.new(
          username: username,
          profileImage: profileImage,
          images: images,
          caption: caption
        )
    
        # Save the post and respond to the client
        if post.save
          render json: { message: "Post created successfully!", post: post }, status: :created
        else
          render json: { message: "Failed to create post", errors: post.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def index
        # Fetch the current user by username from params
        current_user = Profile.find_by(username: params[:username]) # Adjust as per your user model structure
        return render json: { error: "User not found" }, status: :not_found unless current_user
    
        # Get the list of users the current user follows
        follows = current_user.follows
    
        # Fetch posts created by the users the current user follows and their own posts
        posts = Post.where(:username.in => follows << current_user.username).order_by(created_at: :desc)
    
        # Debugging log (optional)
        puts "Fetched posts: #{posts}"
    
        # Render the posts as JSON response
        render json: posts
      end

end