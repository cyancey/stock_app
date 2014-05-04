class Portfolio
  attr_reader :stocks
  def initialize(stock_objects)
    @stocks = stock_objects
  end
end
