get '/' do
  erb :index
end

get '/feedback' do
	erb :feedback_form
end

get '/profile/:id' do |id|
		@user = User.find(id)
		@organizations = User.find(id).organizations
		@feedbacks= Feedback.where(receiver_id: id)
		erb :profile, layout: false
end