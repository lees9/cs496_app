class User
  include Mongoid::Document
  include ActiveModel::SecurePassword
  field :username, type: String
  field :email, type: String
  field :password_digest, type: String
  index({ username: 1, email: 1}, { unique: true })
  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :username, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 3 }
end
