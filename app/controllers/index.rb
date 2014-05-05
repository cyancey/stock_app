get '/' do
  if logged_in?
    @user = current_user
    erb :home
  else
    erb :index
  end

end

post '/login' do
  @user = User.find_by_email(params[:email])

  p params
  if @user.password == params[:password]
    session[:user_id] = @user.id
    puts 'login worked'
    redirect '/'
  else
    redirect '/'
      # redirect_to home_url
  end
end

post '/users' do
  p params
  @user = User.new(params)
  if @user && @user.save
    session[:user_id] = @user.id
  end
  redirect '/'
end

post '/logout' do
  session[:user_id] = nil
  puts "here"
  redirect '/'
end



