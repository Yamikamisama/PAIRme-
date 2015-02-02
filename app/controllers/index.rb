get '/' do
  erb :index
end

get '/feedback' do
	erb :feedback_form
end

get '/profile/:id' do |id|
		@user = User.find(id)
		erb :profile
end