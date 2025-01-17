class SessionsController < ApplicationController
    def create  
      user = User.find_by(username: params[:username])
      puts "#{profile_params}"
      puts user.password
      check = BCrypt::Password.new(user.password) == params[:password]
      puts check
      
      if BCrypt::Password.new(user.password) == params[:password] # Use bcrypt's `authenticate` method
        puts "Authenticate successfully"
        # session[:username] = user.username
        token = generate_token(user) # Generate a JWT or session token for authentication
        # puts decode("eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoidGVjaG1hbjAyNTYiLCJleHAiOjE3MzcwNDE2MDJ9.c9yU-ZIIRkUHCTv22jaNuMOxZJcWaZP5QLD_KXdWI9w")
      render json: { message: 'Sign-in successful', token: token, username:user.username }, status: :ok
      else
        render json: { error: 'Invalid username or password' }, status: :unauthorized
      end
    end
    def verify
      token = request.headers['Authorization'].to_s
      puts token
      payload = decode token

      if payload
        render json: { message: 'Token is valid', username: payload['user_id'] }, status: :ok
      else
        render json: { error: 'Token is invalid' }, status: :unauthorized
      end
    end
  
    
    private
    
    
    def decode(token)
      decoded = JWT.decode(token, JWT_SECRET, true, { algorithm: 'HS256' })
      decoded[0] # The first element contains the payload
    rescue JWT::DecodeError => e
      Rails.logger.error("JWT Decode Error: #{e.message}")
      nil
    end
    # Method to generate a session token (e.g., a JWT)
    def generate_token(user)
      JWT.encode({ user_id: user.username, exp: 10.minutes.from_now.to_i }, JWT_SECRET)
    end

    def profile_params
        params.require(:session).permit(:username, :password)
    end

  end
  