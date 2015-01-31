class User < ActiveRecord::Base
  has_secure_password

  validates :email, :password, presence: true

  has_many :sessions
  has_many :feedbacks
  belongs_to :organization
# class User < ActiveRecord::Base
#   validates :username, :password, presence: true

#   has_secure_password
# end

class Student
  attr_reader :id, :name
  def initialize(args)
    @id = args[:id]
    @name = args[:name]
  end
end

class Organization
  attr_accessor :members
  def initialize(*student)
    @members = []
    @members << student
    @members.flatten!
  end

  def add(*student)
    members << student
    members.flatten!
  end

  def remove(student)
    members.delete(*student)
    members.flatten!
  end
end

class Feedback
  attr_reader :student, :rating1, :rating2, :rating3, :text, :all_ratings
  def initialize(args)
    @student = args[:student]
    @rating1 = args[:q1]
    @rating2 = args[:q2]
    @rating3 = args[:q3]
    @text = args[:text]
    @all_ratings = [@rating1, @rating2, @rating3]
  end

  def average
    all_ratings.reduce(:+) / all_ratings.length
  end

  def driver_score
    rating1
  end

  def navigator_score
    rating2
  end

  def overall_score
    rating3
  end

end


ivan = Student.new(id: 1, name: "Ivan Birkman")
lucas = Student.new(id: 2, name: "Lucas Santos")
justin = Student.new(id: 3, name: "Justin Gaba")
rayan = Student.new(id: 4, name: "Rayan Boutaleb")
kevin = Student.new(id: 5, name: "Kevin Alwell")

squirrels = Organization.new(ivan, lucas)
squirrels.add(justin, rayan, kevin)
squirrels.remove(kevin)

to_ivan = Feedback.new(student: ivan, q1: 4, q2: 3, q3: 4, text: "Good sesh but please shower before classes.")


class Session
  def initialize(student1, student2)

  end


  def self.random_pair(organization)
    organization.members.sample(2)
  end

  def self.select_pair(student1, student2, organization)
    pair = []
    organization.members.each do |student|
      pair << student if student == student1
      pair << student if student == student2
    end
    pair
  end
end


p Session.random_pair(squirrels)
# p Session.select_pair(ivan, lucas, squirrels)