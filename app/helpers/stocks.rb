def user_stock_data(user)
  stock_symbols = []
  user.user_stocks.each do |user_stock|
    stock_symbols << user_stock.ticker_symbol
  end
  StockFactory.stocks(stock_symbols)
end

def user_stock_data_with_share_quantity(user)
  share_quantities = user.user_stocks.map do |user_stock|
    user_stock.share_quantity
  end
  apply_share_quantity_to_stock_objects(user_stock_data(user), share_quantities)

  # counter = 0
  # user_stock_data(user).each do |stock_object|
  #   stock_object.user_shares = share_quantities[counter]
  #   counter += 1
  # end
end

def new_stocks(stock_quotes_array, share_quantity_array)
  stocks = StockFactory.stocks(stock_quotes_array)
  stocks_with_qty = apply_share_quantity_to_stock_objects(stocks, share_quantity_array)
  p stocks_with_qty
end

def apply_share_quantity_to_stock_objects(stock_objects, share_quantities)
  counter = 0
  stock_objects.each do |stock_object|
    stock_object.user_shares = share_quantities[counter]
    counter += 1
  end
end

# def apply_user_stock_id_to_stock_obj(user)
#   user_stock_ids = user.user_stocks.map do |user_stock|
#     user_stock.id
#   end
#   counter = 0
#   user_stock_data(user).each do |stock_object|
#     stock_object.id = user_stock_ids[counter]
#     counter += 1
#   end
# end

def convert_added_stocks_to_nested_array(params)
  stock_inputs = []
  params.each_slice(2) {|stock_input| stock_inputs << stock_input}
  stock_inputs
end

def inputs_for_adding_stocks(params)
  convert_added_stocks_to_nested_array(params).map do |stock_input|
    {ticker_symbol: stock_input[0][1], share_quantity: stock_input[1][1]}
  end
end