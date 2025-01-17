# app/models/profile.rb
class Profile
    include Mongoid::Document
    include Mongoid::Timestamps
  
    field :username, type: String
    field :title, type: String
    field :bio, type: String
    field :profileImage, type: String
    field :stories, type: Array, default: []
    field :follows, type: Array, default: []
    field :followers, type: Array, default: []
  
    validates :username, presence: true, uniqueness: true
  
    index({ username: 1 }, unique: true) # Ensure unique usernames
  end
  