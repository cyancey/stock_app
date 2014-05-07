# require 'net/http'
# require 'json'
# require 'rest-client'



# class Stock
#   attr_reader :symbol, :avg_daily_vol, :change, :daily_low, :daily_high, :year_low, :year_high, :mkt_cap, :last_trade_price, :daily_range, :name, :volume
#   def initialize(args)
#     @symbol = args.fetch("symbol", nil)
#     @avg_daily_vol = args.fetch("AverageDailyVolume", nil).to_i
#     @change = args.fetch("Change", nil).to_f
#     @daily_low = args.fetch("DaysLow", nil).to_f
#     @daily_high = args.fetch("DaysHigh", nil).to_f
#     @year_low = args.fetch("YearLow", nil).to_f
#     @year_high = args.fetch("YearHigh", nil).to_f
#     @mkt_cap = args.fetch("MarketCapitalization", nil)
#     @last_trade_price = args.fetch("LastTradePriceOnly", nil).to_f
#     @daily_range = args.fetch("DaysRange", nil)
#     @name = args.fetch("Name", nil)
#     @volume = args.fetch("Volume", nil).to_i
#     @stock_exchange = args.fetch("StockExchange", nil)
#   end
# end

# class Portfolio
#   attr_reader :stocks
#   def initialize(stock_objects)
#     @stocks = stock_objects
#   end
# end

# module Factory
#   def self.stocks(quotes_array)
#     stocks_array = []
#     query_results = stock_query(quotes_array)
#     query_results.each do |stock_quote_data|
#       stock = Stock.new(stock_quote_data)
#       stocks_array << stock
#     end
#     stocks_array
#   end
# end

# portfolio = Portfolio.new(Factory.stocks(['AAPL', 'AMZN']))
# p portfolio.stocks
