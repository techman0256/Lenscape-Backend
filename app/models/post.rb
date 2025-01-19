class Post
    include Mongoid::Document
    include Mongoid::Timestamps
  
    # Fields
    field :username, type: String
    field :images, type: Array # Storing multiple image URLs
    field :profileImage, type: String
    field :caption, type: String
    field :likes, type: Integer, default: 0
    field :comments, type: Array, default: [] # Array of hashes for comments
  
    # Validations
    validates :username, presence: true
    validates :images, presence: true
    validates :caption, length: { maximum: 500 }
  
    # Relationships (optional)
    # belongs_to :user (if you have a User model)
  
    # Instance Methods
    def add_like
      self.inc(likes: 1) # Increment likes by 1
    end
  
    def add_comment(username:, text:)
      self.push(comments: { username: username, text: text, created_at: Time.now })
    end
  end
  