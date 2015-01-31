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
  attr_reader :name
  def initialize(args)
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
  attr_reader :rating1, :rating2, :rating3, :text
  def initialize(args)
    @rating1 = args[:q1]
    @rating2 = args[:q2]
    @rating3 = args[:q3]
    @text = args[:text]
  end

  def all_ratings
    [rating1, rating2, rating3]
  end

  def average

  end
end


ivan = Student.new(name: "Ivan Birkman")
lucas = Student.new(name: "Lucas Santos")
justin = Student.new(name: "Justin Gaba")
rayan = Student.new(name: "Rayan Boutaleb")
kevin = Student.new(name: "Kevin Alwell")

squirrels = Organization.new(ivan, lucas)
squirrels.add(justin, rayan, kevin)
squirrels.remove(kevin)


module Session
  class << self
    def random_pair(organization)
      organization.members.sample(2)
    end

    def select_pair(student1, student2, organization)
      pair = []
      organization.members.each do |student|
        pair << student if student == student1
        pair << student if student == student2
      end
      pair
    end
  end
end


# p Session.random_pair(squirrels)
# p Session.select_pair(ivan, lucas, squirrels)