$(document).ready(function() {
  setListeners()
});

function setListeners() {
  // $("#add_stocks_link").on('click', showAddStocksForm)
  $(".home").on('click', "#add_stocks_link", showAddStocksForm)



  // $("#cancel_stock_add_link").on('click', cancelStockAdd)
  $(".home").on('click', "#cancel_stock_add_link", cancelStockAdd)


  // $("#add_another_stock").on('click', addAnotherStock)

  $(".home").on('click', "#add_another_stock", addAnotherStock)


  $(".stock_list").on('click', '.delete_stock', deleteStock)

  $(".home").on('submit', "#add_stock_form", addStocks)
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
  // $("#cancel_stock_add_link").toggleClass("hidden")
  // $("#add_stocks_link").toggleClass("hidden")
  // $("#add_stock_form").toggleClass("hidden")
  // $("#add_another_stock").toggleClass("hidden")
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
}

function resetAddStockForm() {
  $(".add_stocks").remove()
  var ajaxRequest = $.ajax({
    url: 'users/stocks/new',
    type: 'GET'
  })

  ajaxRequest.done(appendAddStockForm)
}

function appendAddStockForm(response) {
  $(".add_stock_container").append(response)
}

function addStocks(event) {
  event.preventDefault()

  var ajaxRequest = $.ajax({
    url: '/users/stocks',
    type: 'POST',
    data: $(this).serialize()
  })

  ajaxRequest.done(appendNewStocks)
}

function appendNewStocks(response) {
  $(".stock_list").append($(response).html())
}