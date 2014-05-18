###Boiler Room
This is a single page stock tracking app (once logged in) which allows users to enter stock quotes and share quantities.  The backend is written in Ruby and utilizes Sinatra.  Adding stocks, editing share quantites and obtaining detailed information for stocks are accomplished through AJAX calls to the server.  All portfolio calculations (individual stock and portfolio totals) are performed client side in JavaScript.

Stock information is obtained via the Yahoo Finance API.