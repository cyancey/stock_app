$(document).ready(function() {
  setListeners()
  updateAllShareValues()
  updatePortfolioValue()
});

function setListeners() {
  $(".home").on('click', "#add_stocks_link", showAddStocksForm)
  $(".home").on('click', "#cancel_stock_add_link", cancelStockAdd)
  $(".home").on('click', "#add_another_stock", addAnotherStock)
  $(".stock_list").on('click', '.delete_stock', deleteStock)
  $(".home").on('submit', "#add_stock_form", addStocks)
  $(".home").on('click', ".more_info", moreInfo)
}

function showAddStocksForm(event) {
  event.preventDefault()
  $("#add_stock_form").toggleClass("hidden")
  $("#add_stocks_link").toggleClass("hidden")
  $("#cancel_stock_add_link").toggleClass("hidden")
  $("#add_another_stock").toggleClass("hidden")
}

function cancelStockAdd() {
  event.preventDefault()
  resetAddStockForm()
}

function addAnotherStock() {
  event.preventDefault()
  var add_stock_form = $("#add_stock_form")
  $("#end_form_break").remove()
  $("#add_stock_form_submit").remove()
  add_stock_form.append("<br>")
  var ticker_symbol_field = add_stock_form.append("<input type='text' name='ticker_symbol' placeholder = 'Ticker Symbol'>")
  var share_quantity_field = add_stock_form.append("<input type='text' name='share_quantity' placeholder = 'Number of Shares'>")
  add_stock_form.append("<br id='end_form_break'>")
  add_stock_form.append("<input type = 'submit' value= 'Add Stock' id='add_stock_form_submit'>")
  numberAddStockFormInputs()
}

function numberAddStockFormInputs() {
  addStockFormFields = $('#add_stock_form input')
  counter = 0
  for(i=0; i<addStockFormFields.length; i++) {
    if (i !== addStockFormFields.length - 1)
    {
    fieldPosition = Math.floor(counter/2)
    nameAttribute = addStockFormFields[i].getAttribute('name')
    addStockFormFields[i].setAttribute('name', nameAttribute + fieldPosition)
    counter++
    }
  }
}

function deleteStock(event) {
  event.preventDefault
  var ticker_symbol = this.dataset.symbol
  var ajaxRequest = $.ajax({
    url: '/users/stocks',
    type: 'DELETE',
    data: {ticker_symbol: ticker_symbol}
  })

  ajaxRequest.done(removeStockElement)
}

function removeStockElement(response) {
  $("#"+response).remove()
  updatePortfolioValue()
}

function resetAddStockForm() {
  $("#request_status").text("Request Processing")
  $("#request_status").toggleClass("hidden")
  $(".add_stocks").remove()
  var ajaxRequest = $.ajax({
    url: 'users/stocks/new',
    type: 'GET'
  })

  ajaxRequest.done(appendAddStockForm)
}

function appendAddStockForm(response) {
  $("#request_status").toggleClass("hidden")
  $(".add_stock_container").append(response)

}

function addStocks(event) {
  event.preventDefault()

  var ajaxRequest = $.ajax({
    url: '/users/stocks',
    type: 'POST',
    data: $(this).serialize()
  })

  resetAddStockForm()

  ajaxRequest.done(appendNewStocks)
}

function appendNewStocks(response) {
  $(".stock_list").append($(response))
  updateAllShareValues()
  updatePortfolioValue()
}

function calculateStockValue(stockDetailElement) {
  var stockData = stockDetailElement.dataset
  var shareValue = parseFloat(stockData.price) * parseFloat(stockData.shareQuantity)
  return Math.floor(shareValue*100)/100
}

function updateShareValue(stockDetailElement) {
  var shareValue = calculateStockValue(stockDetailElement)
  var shareValueElement = stockDetailElement.querySelector(".user_share_value")

  if (isNaN(shareValue))
  {
    shareValue = 0
  }
  stockDetailElement.setAttribute('data-user-share-value', shareValue)

  shareValueElement.textContent = "$ " +formatNumsWithCommas(shareValue)
}

function formatNumsWithCommas(number) {
  return number.toLocaleString()
}

function updateAllShareValues() {
  var stockDetailElements = document.querySelectorAll(".stock_detail")
  for (var i = 0; i < stockDetailElements.length; i++) {
    updateShareValue(stockDetailElements[i])
  }
}

function calculatePortfolioTotal() {
  var stockDetailElements = document.querySelectorAll(".stock_detail")
  var total = 0
  for (var i = 0; i < stockDetailElements.length; i++) {
    var shareValue = parseFloat(stockDetailElements[i].dataset.userShareValue)
    total += shareValue
  }
  return total
}

function updatePortfolioValue() {
  var portfolioValueElement = document.querySelector("#portfolio-total")
  var portfolioValue = calculatePortfolioTotal()
  portfolioValueElement.textContent = "Portfolio Total: $ " + formatNumsWithCommas(portfolioValue)

  portfolioValueElement.setAttribute('data-portfolio-value', portfolioValue)
}

function moreInfo(event) {
  event.preventDefault()
  var ticker_symbol = this.dataset.symbol

  var ajaxRequest = $.ajax({
    url: '/users/stocks/more_info',
    type: 'GET',
    data: {ticker_symbol: ticker_symbol}
  })

  ajaxRequest.done(appendMoreInfo)
}

function appendMoreInfo(response) {
  console.log(response)
  var stock = JSON.parse(response)
  createStockInfoDiv(stock)
}

function createStockInfoDiv(stockJSON) {
  var stockDetailElement = document.querySelector('#'+stockJSON["symbol"])

  var moreDetailedInfo = document.createElement("div")
  moreDetailedInfo.classList.add("more_detailed_info")
  var stockInfo = document.createElement("p")

  stockInfo.textContent = stockJSON["Change_PercentChange"]

  moreDetailedInfo.appendChild(stockInfo)

  stockDetailElement.appendChild(moreDetailedInfo)



}
