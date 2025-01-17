# Load Rails environment
require_relative './config/environment'

# Sample user
user = User.find_or_create_by(id: '12345') do |u|
  u.name = 'John Doe'
#   u.profile_image = 'https://picsum.photos/1050/1920'
end

# Sample stories
stories_data = [
  {
    user_id: user.id,
    type: 'image',
    url: 'https://picsum.photos/1080/1920', # Random image from Lorem Picsum
    duration: 5,
    header: {
      heading: user.name,
      subheading: 'Posted 5 minutes ago',
    },
    created_at: 5.minutes.ago
  },
  {
    user_id: user.id,
    type: 'image',
    url: 'https://picsum.photos/1080/1920',
    duration: 5,
    header: {
      heading: user.name,
      subheading: 'Posted 10 minutes ago',
    },
    created_at: 10.minutes.ago
  }
]

# Insert stories into the database
stories_data.each do |story_data|
  Story.create!(story_data)
end

puts "Seed data added successfully!"
