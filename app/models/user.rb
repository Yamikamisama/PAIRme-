class User < ActiveRecord::Base
  has_secure_password
  
  validates :email, :password, presence: true

  has_many :sessions
  has_many :feedbacks
  belongs_to :organization
end
