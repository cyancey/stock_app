get '/' do
  # Look in app/views/index.erb
  erb :index

  response = RestClient.get 'https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.quotes%20where%20symbol%20in%20(%22YHOO%22%2C%22AAPL%22%2C%22GOOG%22%2C%22MSFT%22)&format=json&diagnostics=true&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback='

  what = JSON.parse(response)
  puts what

end

get '/query' do
  query_string_prefix = "https://query.yahooapis.com/v1/public/yql?q="
  query_suffix = "select * from yahoo.finance.quotes where symbol in ('YHOO','AAPL','GOOG','MSFT')"

  response = RestClient.get "#{query_string_prefix}#{query_suffix}"
  # p RestClient.get "http://query.yahooapis.com/v1/public/yql?q=select * from geo.places where text='sunnyvale, ca'"

end




