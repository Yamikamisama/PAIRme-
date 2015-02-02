class User < ActiveRecord::Base
  has_secure_password

  validates :email, :password, presence: true

  has_many :sessions, foreign_key: :user1_id
  has_many :sessions, foreign_key: :user2_id
  has_many :feedbacks, foreign_key: :receiver_id
  has_many :feedbacks, foreign_key: :giver_id
  has_many :organizations through: :organization_users
  # def paired_with(student)
  #   pair_to_look_for = [self.id, student.id]

  #   Session.where((student1.id == pair_to_look_for[0] && student2.id == pair_to_look_for[1]) || (student1.id == pair_to_look_for[1] && student2.id == pair_to_look_for[0]))

  # end

end
# class User < ActiveRecord::Base
#   validates :username, :password, presence: true

#   has_secure_password
# end

# class User
#   attr_reader :id, :name
#   def initialize(args)
#     @id = args[:id]
#     @name = args[:name]
#   end

  # def paired_with(student)
  #   pair_to_look_for = [self.id, student.id]

  #   Session.where((student1.id == pair_to_look_for[0] && student2.id == pair_to_look_for[1]) || (student1.id == pair_to_look_for[1] && student2.id == pair_to_look_for[0]))

  # end
# end

# class Organization
  # attr_accessor :members
  # def initialize(*student)
  #   @members = []
  #   if student.length == 1
  #     @members << student[0]
  #   else
  #     @members = student
  #   end
  # end

  # def add(*student)
  #   student.each { |stu| members << stu }
  #   self
  # end

  # def remove(student)
  #   members.delete(*student)
  #   self
  # end
# end

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

# class Feedback
#   attr_reader :student, :rating1, :rating2, :rating3, :text, :all_ratings
#   def initialize(args)
#     @student = args[:student]
#     @rating1 = args[:q1]
#     @rating2 = args[:q2]
#     @rating3 = args[:q3]
#     @text = args[:text]
#     @all_ratings = [@rating1, @rating2, @rating3]
#   end

#   def average
#     all_ratings.reduce(:+) / all_ratings.length
#   end

#   def driver_score
#     rating1
#   end

#   def navigator_score
#     rating2
#   end

#   def overall_score
#     rating3
#   end
# end

# class Session
#   attr_accessor :student1, :student2, :feedback1, :feedback2
#   def initialize(args)
#     @student1 = args[0]
#     @student2 = args[1]
#   end

#   def add_feedback(feedback)
#     pair_id = [self.student1.id, self.student2.id]

#     if pair_id[0] == feedback.student.id
#       self.feedback1 = feedback
#       pair_id.delete(feedback.student.id)
#     end
#     if pair_id[1] == feedback.student.id
#       self.feedback2 = feedback
#       pair_id.delete(feedback.student.id)
#     end
#   end
# end


# ivan = User.new(id: 1, name: "Ivan Birkman")
# lucas = User.new(id: 2, name: "Lucas Santos")
# justin = User.new(id: 3, name: "Justin Gaba")
# rayan = User.new(id: 4, name: "Rayan Boutaleb")
# kevin = User.new(id: 5, name: "Kevin Alwell")

# squirrels = Organization.new(ivan, lucas)
# squirrels.add(justin, rayan, kevin)
# squirrels.remove(kevin)

# MakePair.random_pair(ivan, squirrels)
# new_session = MakePair.select_pair(ivan, lucas)

# to_ivan = Feedback.new(student: ivan, q1: 4, q2: 3, q3: 4, text: "Good sesh but please shower before classes.")
# to_lucas = Feedback.new(student: lucas, q1: 4, q2: 3, q3: 4, text: "Good seeeeeeesh but please shower before classes.")
# to_rayan = Feedback.new(student: rayan, q1: 4, q2: 3, q3: 4, text: "Good seeeeeeesh but please shower before classes.")

# new_session.add_feedback(to_ivan)
# p new_session
# new_session.add_feedback(to_rayan)
# p new_session
# new_session.add_feedback(to_lucas)
# p new_session