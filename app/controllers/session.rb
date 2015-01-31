post '/session' do
	user1 = User.find_by(email: params["user1"]["email"])
	# .try(:authenticate, params["user1"])
	user2 = User.find_by(email: params["user2"]["email"])

	if user1 && user2
		Session.create(user1: user1, user2: user2)
		{ :user1 => user1.email, :user2 => user2.email}.to_json
	else
		500
	end

end

# post '/session/data' do
# 	session = Session.find_by(user1:

# 	cur_session = session.pop
# 	cur_session.update(:active , :downtime, :duration)
# end