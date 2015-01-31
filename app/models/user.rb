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
    def random_pair(students)
      students.sample(2)
    end
  end
end
