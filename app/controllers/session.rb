post '/session' do
	user1 = User.find_by(email: params["user1"]["email"])
	user2 = User.find_by(email: params["user2"]["email"])

	if user1.authenticate(params["user1"]["password"]) && user2.authenticate(params["user2"]["password"])

		{ :user1 => user1.email, :user2 => user2.email}.to_json
	else
		"Authentication Failed Please Try Again"
	end

end

post '/session/data' do
	interval_info = params["session"]
	session = Session.create()

	counter = 0
	while interval_info[counter.to_s]
		current_interval = interval_info[counter.to_s]
		driver = User.find_by(email:current_interval['drive'])
		navigator = User.find_by(email:current_interval['navigate'])

		if counter == 0
			session.users = [driver, navigator]
			session.feedbacks.create(giver: driver, receiver: navigator)
			session.feedbacks.create(giver: navigator, receiver: driver)
		end

		session.intervals.create(active_time: current_interval["timeWorked"], pause_time: current_interval["timePaused"], driver: driver, navigator: navigator)
		counter += 1
	end
	"Success"

	sendgrid = SendGrid::Client.new(api_user: pairmeup, api_key: api_key)
 
	email = SendGrid::Mail.new do |m|
	  m.to      = 'stephanie.reaves@gmail.com'
	  m.from    = 'stephanie.reaves@gmail.com'
	  m.subject = 'Sending with SendGrid is Fun'
	  m.html    = 'and easy to do anywhere, even with Ruby'
	end
 
	sendgrid.send(email)
end