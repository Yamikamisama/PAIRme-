class User < ActiveRecord::Base
  has_secure_password
  has_many :organization_members
  has_many :organizations, through: :organization_members
  has_many :feedbacks_given, class_name: "Feedback", foreign_key: "giver_id"
  has_many :feedbacks_received, class_name: "Feedback", foreign_key: "receiver_id"
  has_many :user_sessions
  has_many :sessions, through: :user_sessions

  validates :email, :password, presence: true

  def email_hashify
    hash = Digest::MD5.hexdigest(email.downcase)
  end

end

module MakePair
  def self.random_pair(student1)
    arr = []
    arr = User.where(organization_id: student1.organization.id)
    arr.delete(student1)
    random_student = arr.sample
    Session.create(user1: student1.id, user2: random_student.id)
  end

  def self.select_pair(student1, student2)
    Session.create(user1: student1.id, user2: student2.id)
  end
end

