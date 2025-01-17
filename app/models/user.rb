class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :username, type: String
  field :email, type: String
  field :password, type: String


  # Validation for required fields
  validates :username, presence: true
  validates :email, presence: true
  validates :password, presence: true
end
