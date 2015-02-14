class Session < ActiveRecord::Base
  has_many :intervals
  has_many :feedbacks
  has_many :user_sessions
  has_many :users, through: :user_sessions
end
