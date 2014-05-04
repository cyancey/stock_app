require_relative "../app/models/Stock"
require_relative "../app/models/StockQueryDetailed"
require_relative "../app/models/StockFactory"
require_relative "../app/models/Portfolio"

StockFactory.stocks(['AAPL', 'LUV'])
p portfolio = Portfolio.new(StockFactory.stocks(['AAPL', 'BBY']))
