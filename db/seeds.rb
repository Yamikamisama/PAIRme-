require "faker"

nums = (1..5).to_a
times = [20, 25, 30, 35, 40, 45, 60]
organizations = ["DBC", "Owls", "Ospreys", "Google"]

users = [
{username: 'Stephanie Reaves', email: 'steph@steph.com', password: '123456', driver_score: nums.sample, navigator_score: nums.sample},
{username: 'Michael Angelo', email: 'me@me.com', password: '123456', driver_score: nums.sample, navigator_score: nums.sample},
{username: 'Nathan Zeplowitz', email: 'test@test.com', password: '123456', driver_score: nums.sample, navigator_score: nums.sample},
{username: 'Matthew DeCarlo', email: 'nathan@nate.com.com', password: '123456', driver_score: nums.sample, navigator_score: nums.sample},
{username: 'Ivan Hawng', email: 'bob@bob.com', password: '123456', driver_score: nums.sample, navigator_score: nums.sample},
{username: 'Kimberly Fraiser', email: 'jon@doe.com', password: '123456', driver_score: nums.sample, navigator_score: nums.sample}
]

organizations.each { |org| Organization.create(name: org) }

users.each {|user_info| Organization.all.sample.users << User.create(user_info)}

10.times do
  session = Session.create()
  users = User.all.shuffle
  user1 = users.first
  user2 = users.last
  session.users << user1
  session.users << user2
  Feedback.create(q1: nums.sample, q2: nums.sample, q3: nums.sample, content: Faker::Lorem.paragraph, receiver: user1, giver: user2, session: session)
  3.times do
    Interval.create(active_time: times.sample, pause_time: times.sample, driver: user1, navigator: user2, session: session)
    user = user1
    user1 = user2
    user2 = user
  end
end


