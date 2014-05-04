get '/' do
  @user = User.find(session[:user_id])
  erb :index

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
  @user.save!
  redirect '/'
end



