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
