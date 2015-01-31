require 'faker'

organization = Organization.create(name: "DBC")

9.times do
  Organization.create(name: Faker::Company.name)
end

user = User.create(email: 'steph@steph.com', password: '123456', driver: 5, navigator: 5, organization_id: 1)

9.times do
  User.create(email: Faker::Internet.email, password: '123456', driver: 3, navigator: 4, organization_id: 3)
end


session = Session.create(duration: 60, downtime: 30, active: 30, user_id: 1)

feedback = Feedback.create(q1: 4, q2: 3, q3: 5, text: "lallalala", user_id: 1, session_id: 1)


