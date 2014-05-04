module StockFactory
  def self.stocks(quotes_array)
    stocks_array = []
    query_results = StockQuery.stock_query(quotes_array)
    query_results.each do |stock_quote_data|
      stock = Stock.new(stock_quote_data)
      stocks_array << stock
    end
    stocks_array
  end
end