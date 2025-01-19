class StoriesController < ApplicationController
  def index
    # Assuming A (the current user) is available in the session or params
    current_user = Profile.find_by(username: params[:username]) # Replace `params[:current_user]` with how you get the current user
    follows = current_user.follows
    
    # Fetch stories from users A follows
    # puts "reached till here #{follows}"
    # stories = Story.where(username: follows, created_at: { gte: 168.hours.ago })

    stories = Story.where(:username.in => follows << current_user.username, :created_at.gte => 168.hours.ago)


    
    puts "These are stories #{stories}"
    render json: stories
  end
  
  
    def create
      puts "helllooooooooo #{params[:urls].class}"
      # check type of params header


      # puts "this is params : #{story_params}"
      @story = Story.new({username: params[:username], type: params[:type], urls: params[:urls], duration: params[:duration], header: params[:header].to_h})
      puts "story.urls : #{@story.username}"
      puts "story.urls : #{@story.urls}"
      puts "story.header : #{@story.header}"

      if @story.save
        render json: @story, status: :created
      else
        render json: { errors: @story.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    private  
    # def story_params
    #   params.require(:story).permit(:username, :type, :urls, :duration, header: [:heading, :subheading, :profileImage])
    # end
  end
  