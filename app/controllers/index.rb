get '/' do
  @users = User.all
  # render home page
  #TODO: Show all users if user is signed in
  erb :index
end

#----------- SESSIONS -----------

get '/sessions/new' do
  # render sign-in page
  erb :sign_in
end

post '/sessions' do
  user = User.find_by_email(params[:email])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    erb :index
  else
    @error = "Really sorry. Your shit failed for some reason."
    erb :sign_in
  end
end

delete '/sessions/:id' do
  session.clear
end

#----------- USERS -----------

get '/users/new' do
  # render sign-up page
  erb :sign_up
end

post '/users' do
  user = User.new(params[:user])
  if user.save
    session[:user_id] = user.id
    erb :index
  else
    erb :sign_up
  end
end
