get '/' do
  if logged_in?
    @user = current_user
    if @user.user_stocks.count > 0
      @stocks = user_stock_data_with_share_quantity(@user)
      p @stocks
    end
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
  redirect '/'
end

post '/users/stocks' do
  stock_symbols = []
  share_quantities = []
  inputs_for_adding_stocks(params).each do |stock_input|
    unless stock_input[:ticker_symbol].nil? || stock_input[:ticker_symbol] == ""
      stock = current_user.user_stocks.create(ticker_symbol: stock_input[:ticker_symbol], share_quantity: stock_input[:share_quantity])
      stock_symbols << stock.ticker_symbol
      share_quantities << stock.share_quantity
    end
  end
  @stocks = new_stocks(stock_symbols, share_quantities)

  erb :_stock_list, layout:false
end

get '/users/stocks/new' do
  erb :_add_stock, layout: false
end

delete '/users/stocks' do
  ticker_symbol = params["ticker_symbol"]
  p user = User.find(session[:user_id])
  user.user_stocks.find_by_ticker_symbol(ticker_symbol).destroy
  ticker_symbol
end


