require_relative '../app/models/yql'

# results = stock_query(['AMZN', 'AAPL'])
dummy_data = [{"symbol"=>"AAPL", "AverageDailyVolume"=>"10063700", "Change"=>"+1.10", "DaysLow"=>"589.71", "DaysHigh"=>"594.20", "YearLow"=>"388.87", "YearHigh"=>"599.43", "MarketCapitalization"=>"510.4B", "LastTradePriceOnly"=>"592.58", "DaysRange"=>"589.71 - 594.20", "Name"=>"Apple Inc.", "Symbol"=>"AAPL", "Volume"=>"6839796", "StockExchange"=>"NasdaqNM"}, {"symbol"=>"VTSMX", "AverageDailyVolume"=>"0", "Change"=>"-0.03", "DaysLow"=>nil, "DaysHigh"=>nil, "YearLow"=>nil, "YearHigh"=>nil, "MarketCapitalization"=>nil, "LastTradePriceOnly"=>"47.43", "DaysRange"=>"N/A - N/A", "Name"=>"Vanguard Index Tr", "Symbol"=>"VTSMX", "Volume"=>nil, "StockExchange"=>"NasdaqSC"}]

def dummy_stocks(dummy_data)
  stocks_array = []
  dummy_data.each do |stock_quote_data|
    stock = Stock.new(stock_quote_data)
    stocks_array << stock
  end
  stocks_array
end

fake_stocks = dummy_stocks(dummy_data)

portfolio = Portfolio.new(fake_stocks)
p  portfolio.stocks

portfolio.stocks[0]

