class Story
  include Mongoid::Document
  include Mongoid::Timestamps

  # Fields
  field :username, type: String
  field :type, type: String # 'image' or 'video'
  field :urls, type: Array
  field :duration, type: Integer, default: 5
  field :header, type: Hash, default: {}
  field :created_at, type: Time, default: -> { Time.now }

  # Validations
  validates :username, presence: true
  validates :type, presence: true, inclusion: { in: %w[image video] }
  validates :urls, presence: true
  validates :duration, numericality: { greater_than: 0 }

  # Relationships
end
