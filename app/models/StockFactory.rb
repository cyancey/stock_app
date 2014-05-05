require_relative 'StockQueryDetailed'

module StockFactory
  def self.stocks(quotes_array)
    stocks_array = []
    query_results = StockQuery.stock_query(quotes_array)

    if quotes_array.length == 1
      stock = Stock.new(query_results)
      stocks_array << stock
    else
      query_results.each do |stock_quote_data|
        stock = Stock.new(stock_quote_data)
        stocks_array << stock
      end
    end
    stocks_array
  end
end