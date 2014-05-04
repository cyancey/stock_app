get '/' do
  # Look in app/views/index.erb
  erb :index

end

get '/login' do
  @user = User.find_by_email(params[:email])
  if @user.password == params[:password]
    # give_token
  else
      # redirect_to home_url
  end
end




