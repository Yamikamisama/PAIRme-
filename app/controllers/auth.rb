get '/signup' do

  erb :"auth/signup"
end

post '/signup' do
  new_user = User.new(params[:new_user])
  if new_user.save
    session[:user_id] = new_user.id
  else
    set_error("Please enter valid password/username.")
  end

  if request.xhr?
    erb :welcome, layout: false
  else
    redirect '/'
  end
end

get '/login' do

  erb :"auth/login"
end

post '/login' do
  user = User.find_by(username: params[:username]).try(:authenticate, params[:password])
  if user
    session[:user_id] = user.id
  else
    set_error("Log in failed: check username/password")
  end

  if request.xhr?
    erb :welcome, layout: false
  else
    redirect '/'
  end
end

get '/logout' do
  session[:user_id] = nil

  if request.xhr?
    erb :welcome, layout: false
  else
    redirect '/'
  end
end