post '/session' do
	p params
	user1 = User.find_by(email: params["user1"]["email"])
	user2 = User.find_by(email: params["user2"]["email"])

	if user1.authenticate(params["user2"]["password"]) && user2.authenticate(params["user2"]["password"])
		Session.create(user1: user1, user2: user2)
		{ :user1 => user1.email, :user2 => user2.email}.to_json
	else
		"Authentication Failed Please Try Again"
	end

end

post '/session/data' do
	p params
	info = {duration: params["session"]["totalTime"], pause_time: params["session"]["pauseTime"], work_time: params["session"]["activeTime"], user1_drive_time: params["session"]["user1DriverTime"], user2_drive_time: params["session"]["user2DriverTime"]}
	session = Session.new(info)
	if Session.save
		"Success"
		#Create URL generator for Feedback
	else
		500
	end
end