require 'faker'

organization = Organization.create(name: "DBC")

9.times do
  Organization.create(name: Faker::Company.name)
end

user1 = User.create(username: 'steph', email: 'steph@steph.com', password: '123456', driver_score: 5, navigator_score: 5, organization_id: 1)
user2 = User.create(username: 'me', email: 'me@me.com', password: '123456', driver_score: 5, navigator_score: 5, organization_id: 3)

9.times do
  User.create(username: Faker::Internet.user_name, email: Faker::Internet.email, password: '123456', driver_score: 3, navigator_score: 4, organization_id: 3)
end


session = Session.create(duration: 60, pause_time: 30, work_time: 30, user1_drive_time: 15, user2_drive_time: 15, user1_id: user1, user2_id: user2);


