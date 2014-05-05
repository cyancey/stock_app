require 'rest-client'

module StockQuerySimple
  def self.stock_query(quotes_array)
    query = RestClient.get(yql_quotes_query_url(quotes_array))
    JSON.parse(query)["query"]["results"]["quote"]
  end

  def self.parse_result(result)
    result.each do |quote_hash|
      quote_hash.each do |key, value|
        puts "#{key}: #{value}"
      end
      puts "*" * 50
    end
  end

  private

  def self.quotes_to_query_format(quotes_array)
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

  def self.yql_quotes_query_url(quotes_array)
    prefix = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.quote%20where%20symbol%20in%20"
    suffix = "&format=json&diagnostics=true&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback="
    query = quotes_to_query_format(quotes_array)
    "#{prefix}#{query}#{suffix}"
  end
end
# result = [{"symbol"=>"LUV", "Ask"=>nil, "AverageDailyVolume"=>"7236800", "Bid"=>nil, "AskRealtime"=>"24.20", "BidRealtime"=>"24.00", "BookValue"=>"10.301", "Change_PercentChange"=>"-0.15 - -0.62%", "Change"=>"-0.15", "Commission"=>nil, "ChangeRealtime"=>"-0.15", "AfterHoursChangeRealtime"=>"N/A - N/A", "DividendShare"=>"0.16", "LastTradeDate"=>"5/2/2014", "TradeDate"=>nil, "EarningsShare"=>"1.198", "ErrorIndicationreturnedforsymbolchangedinvalid"=>nil, "EPSEstimateCurrentYear"=>"1.49", "EPSEstimateNextYear"=>"1.72", "EPSEstimateNextQuarter"=>"0.42", "DaysLow"=>"23.99", "DaysHigh"=>"24.39", "YearLow"=>"12.58", "YearHigh"=>"24.63", "HoldingsGainPercent"=>"- - -", "AnnualizedGain"=>nil, "HoldingsGain"=>nil, "HoldingsGainPercentRealtime"=>"N/A - N/A", "HoldingsGainRealtime"=>nil, "MoreInfo"=>"cn", "OrderBookRealtime"=>nil, "MarketCapitalization"=>"16.878B", "MarketCapRealtime"=>nil, "EBITDA"=>"2.392B", "ChangeFromYearLow"=>"+11.60", "PercentChangeFromYearLow"=>"+92.21%", "LastTradeRealtimeWithTime"=>"N/A - <b>24.18</b>", "ChangePercentRealtime"=>"N/A - -0.62%", "ChangeFromYearHigh"=>"-0.45", "PercebtChangeFromYearHigh"=>"-1.83%", "LastTradeWithTime"=>"May  2 - <b>24.18</b>", "LastTradePriceOnly"=>"24.18", "HighLimit"=>nil, "LowLimit"=>nil, "DaysRange"=>"23.99 - 24.39", "DaysRangeRealtime"=>"N/A - N/A", "FiftydayMovingAverage"=>"23.6789", "TwoHundreddayMovingAverage"=>"20.5929", "ChangeFromTwoHundreddayMovingAverage"=>"+3.5871", "PercentChangeFromTwoHundreddayMovingAverage"=>"+17.42%", "ChangeFromFiftydayMovingAverage"=>"+0.5011", "PercentChangeFromFiftydayMovingAverage"=>"+2.12%", "Name"=>"Southwest Airline", "Notes"=>nil, "Open"=>"24.38", "PreviousClose"=>"24.33", "PricePaid"=>nil, "ChangeinPercent"=>"-0.62%", "PriceSales"=>"0.96", "PriceBook"=>"2.36", "ExDividendDate"=>"Mar  4", "PERatio"=>"20.31", "DividendPayDate"=>"Mar 27", "PERatioRealtime"=>nil, "PEGRatio"=>"0.60", "PriceEPSEstimateCurrentYear"=>"16.33", "PriceEPSEstimateNextYear"=>"14.15", "Symbol"=>"LUV", "SharesOwned"=>nil, "ShortRatio"=>"2.40", "LastTradeTime"=>"4:01pm", "TickerTrend"=>"&nbsp;+==-+-&nbsp;", "OneyrTargetPrice"=>"25.93", "Volume"=>"6013253", "HoldingsValue"=>nil, "HoldingsValueRealtime"=>nil, "YearRange"=>"12.58 - 24.63", "DaysValueChange"=>"- - -0.62%", "DaysValueChangeRealtime"=>"N/A - N/A", "StockExchange"=>"NYSE", "DividendYield"=>"0.66", "PercentChange"=>"-0.62%"}, {"symbol"=>"AAPL", "Ask"=>nil, "AverageDailyVolume"=>"10063700", "Bid"=>"572.00", "AskRealtime"=>"0.00", "BidRealtime"=>"572.00", "BookValue"=>"139.46", "Change_PercentChange"=>"+1.10 - +0.19%", "Change"=>"+1.10", "Commission"=>nil, "ChangeRealtime"=>"+1.10", "AfterHoursChangeRealtime"=>"N/A - N/A", "DividendShare"=>"12.20", "LastTradeDate"=>"5/2/2014", "TradeDate"=>nil, "EarningsShare"=>"41.727", "ErrorIndicationreturnedforsymbolchangedinvalid"=>nil, "EPSEstimateCurrentYear"=>"44.09", "EPSEstimateNextYear"=>"47.79", "EPSEstimateNextQuarter"=>"9.30", "DaysLow"=>"589.71", "DaysHigh"=>"594.20", "YearLow"=>"388.87", "YearHigh"=>"599.43", "HoldingsGainPercent"=>"- - -", "AnnualizedGain"=>nil, "HoldingsGain"=>nil, "HoldingsGainPercentRealtime"=>"N/A - N/A", "HoldingsGainRealtime"=>nil, "MoreInfo"=>"cnsprmiIed", "OrderBookRealtime"=>nil, "MarketCapitalization"=>"510.4B", "MarketCapRealtime"=>nil, "EBITDA"=>"57.795B", "ChangeFromYearLow"=>"+203.71", "PercentChangeFromYearLow"=>"+52.39%", "LastTradeRealtimeWithTime"=>"N/A - <b>592.58</b>", "ChangePercentRealtime"=>"N/A - +0.19%", "ChangeFromYearHigh"=>"-6.85", "PercebtChangeFromYearHigh"=>"-1.14%", "LastTradeWithTime"=>"May  2 - <b>592.58</b>", "LastTradePriceOnly"=>"592.58", "HighLimit"=>nil, "LowLimit"=>nil, "DaysRange"=>"589.71 - 594.20", "DaysRangeRealtime"=>"N/A - N/A", "FiftydayMovingAverage"=>"541.332", "TwoHundreddayMovingAverage"=>"536.029", "ChangeFromTwoHundreddayMovingAverage"=>"+56.551", "PercentChangeFromTwoHundreddayMovingAverage"=>"+10.55%", "ChangeFromFiftydayMovingAverage"=>"+51.248", "PercentChangeFromFiftydayMovingAverage"=>"+9.47%", "Name"=>"Apple Inc.", "Notes"=>nil, "Open"=>"592.89", "PreviousClose"=>"591.48", "PricePaid"=>nil, "ChangeinPercent"=>"+0.19%", "PriceSales"=>"2.89", "PriceBook"=>"4.24", "ExDividendDate"=>"Feb  6", "PERatio"=>"14.17", "DividendPayDate"=>"May 15", "PERatioRealtime"=>nil, "PEGRatio"=>"0.90", "PriceEPSEstimateCurrentYear"=>"13.42", "PriceEPSEstimateNextYear"=>"12.38", "Symbol"=>"AAPL", "SharesOwned"=>nil, "ShortRatio"=>"2.30", "LastTradeTime"=>"3:59pm", "TickerTrend"=>"&nbsp;==+===&nbsp;", "OneyrTargetPrice"=>"623.78", "Volume"=>"6839796", "HoldingsValue"=>nil, "HoldingsValueRealtime"=>nil, "YearRange"=>"388.87 - 599.43", "DaysValueChange"=>"- - +0.19%", "DaysValueChangeRealtime"=>"N/A - N/A", "StockExchange"=>"NasdaqNM", "DividendYield"=>"2.06", "PercentChange"=>"+0.19%"}]
# StockQuerySimple.parse_result(result)

# p StockQuerySimple.stock_query(['LUV'])