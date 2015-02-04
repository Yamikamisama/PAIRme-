# get '/signup' do

#   erb :"auth/signup"
# end

post '/signup' do
  new_user = User.new(params[:user])
  if new_user.save
    session[:user_id] = new_user.id
    redirect "/profile/#{new_user.id}"
  else
    set_error("Please enter valid password/username.")
  end

  if request.xhr?
    erb :welcome, layout: false
  else
    redirect "/profile/#{new_user.id}"
  end
end

get '/login' do

  erb :profile
end

post '/login' do
  p params[:user][:username]
  p @user = User.find_by(username: params[:user][:username])
  puts "*" * 50
  if @user
    session[:user_id] = @user.id
    redirect "/profile/#{@user.id}"
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