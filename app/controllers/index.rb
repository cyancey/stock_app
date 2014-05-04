get '/' do
  # Look in app/views/index.erb
  erb :index

end

post '/login' do
  @user = User.find_by_email(params[:email])

  p params
  if @user.password == params[:password]
    puts 'login worked'
  else
    redirect '/'
      # redirect_to home_url
  end
end

post '/users' do
  p params
  redirect '/'
end



