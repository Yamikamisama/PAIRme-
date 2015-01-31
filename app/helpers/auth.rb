def current_user
  if session[:user_id]
    return User.find(session[:user_id])
  else
    return nil
  end
end

def same_user?(user)
  return (current_user) && (current_user.id == user.id)
end