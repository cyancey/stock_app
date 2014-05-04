require 'net/http'
require 'json'
require 'rest-client'

extended_prefix = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.quote%20where%20symbol%20in%20"
query_suffix = "&format=json&diagnostics=true&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback="


stock_quotes = ['AAPL', 'VTSMX']

def quotes_to_query_format(quotes_array)
  string = "("
  quotes_array.each.with_index do |quote, index|
    string << "'#{quote}'"
    unless index == quotes_array.length-1
      string << "%2C%20"
    else
      string << ")"
    end
  end
  string
end

def yql_quotes_query_url(quotes_array)
  prefix = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.quote%20where%20symbol%20in%20"
  suffix = "&format=json&diagnostics=true&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback="
  query = quotes_to_query_format(quotes_array)
  "#{prefix}#{query}#{suffix}"
end

def stock_query(quotes_array)
  query = RestClient.get(yql_quotes_query_url(quotes_array))
  JSON.parse(query)["query"]["results"]["quote"]
end

def parse_result(result)
  result.each do |quote_hash|
    quote_hash.each do |key, value|
      puts "#{key}: #{value}"
    end
    puts "*" * 50
  end
end

# results = stock_query(['AMZN', 'AAPL'])
query_result = [{"symbol"=>"AAPL", "AverageDailyVolume"=>"10063700", "Change"=>"+1.10", "DaysLow"=>"589.71", "DaysHigh"=>"594.20", "YearLow"=>"388.87", "YearHigh"=>"599.43", "MarketCapitalization"=>"510.4B", "LastTradePriceOnly"=>"592.58", "DaysRange"=>"589.71 - 594.20", "Name"=>"Apple Inc.", "Symbol"=>"AAPL", "Volume"=>"6839796", "StockExchange"=>"NasdaqNM"}, {"symbol"=>"VTSMX", "AverageDailyVolume"=>"0", "Change"=>"-0.03", "DaysLow"=>nil, "DaysHigh"=>nil, "YearLow"=>nil, "YearHigh"=>nil, "MarketCapitalization"=>nil, "LastTradePriceOnly"=>"47.43", "DaysRange"=>"N/A - N/A", "Name"=>"Vanguard Index Tr", "Symbol"=>"VTSMX", "Volume"=>nil, "StockExchange"=>"NasdaqSC"}]

class Stock
  attr_reader :symbol, :avg_daily_vol, :change, :daily_low, :daily_high, :year_low, :year_high, :mkt_cap, :last_trade_price, :daily_range, :name, :volume
  def initialize(args)
    @symbol = args.fetch("symbol", nil)
    @avg_daily_vol = args.fetch("AverageDailyVolume", nil)
    @change = args.fetch("Change", nil)
    @daily_low = args.fetch("DaysLow", nil)
    @daily_high = args.fetch("DaysHigh", nil)
    @year_low = args.fetch("YearLow", nil)
    @year_high = args.fetch("YearHigh", nil)
    @mkt_cap = args.fetch("MarketCapitalization", nil)
    @last_trade_price = args.fetch("LastTradePriceOnly", nil)
    @daily_range = args.fetch("DaysRange", nil)
    @name = args.fetch("Name", nil)
    @volume = args.fetch("Volume", nil)
    @stock_exchange = args.fetch("StockExchange", nil)
  end
end

class Portfolio
  attr_reader :stocks
  def initialize(stock_objects)
    @stocks = stock_objects
  end
end

module Factory
  def self.stocks(quotes_array)
    stocks_array = []
    query_results = stock_query(quotes_array)
    query_results.each do |stock_quote_data|
      stock = Stock.new(stock_quote_data)
      stocks_array << stock
    end
    stocks_array
  end
end

portfolio = Portfolio.new(Factory.stocks(['AAPL', 'AMZN']))
p portfolio.stocks

# apple = Stock.new(query_result[0])

# p apple

# parse_result(results)

# p quotes_to_query_format(stock_quotes)
# test_query = "#{extended_prefix}#{quotes_to_query_format(stock_quotes)}#{query_suffix}"

# query_results = RestClient.get(test_query)
# query = JSON.parse(query_results)
# query_quote_data = query["query"]["results"]["quote"] # result copied below





# parse_result(query_quote_data)

# https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.quote%20where%20symbol%20in%20('AAPL'%2C%20'MSFT'%2C%20'LUV')&format=json&diagnostics=true&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback=
