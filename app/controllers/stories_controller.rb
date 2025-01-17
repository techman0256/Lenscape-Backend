class StoriesController < ApplicationController
    def index
      # Fetch stories posted in the last 24 hours
      stories = Story.where(:created_at.gte => 180.minutes.ago)
      puts stories
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
  