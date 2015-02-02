post '/session' do
	p params
	user1 = User.find_by(email: params["user1"]["email"])
	user2 = User.find_by(email: params["user2"]["email"])

	if user1.authenticate(params["user2"]["password"]) && user2.authenticate(params["user2"]["password"])
		Session.create(user1: user1, user2: user2)
		{ :user1 => user1.email, :user2 => user2.email}.to_json
	else
		500
	end

end

post '/session/data' do
	# p "8" * 30
	# p params
	# cur_session = params["session"].last_value
	# cur_session.update(:active , :downtime, :duration)
end