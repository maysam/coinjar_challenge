# Code Challenge

## Task Description

Write a simple web app in Ruby or Elixir showing price history of BTC and ETH on
CoinJar Exchange. The application should:

* Capture the prices when a "Capture" button is triggered. This should save
prices of 2 currencies into the database. (Tip: you want to capture the freshest
prices as possible here)
* View a list of currencies and the latest prices.
* Click a link and see the history of captured prices of a currency in descending
order (by time).
* Capture the price of last, bid and ask.

Other points of interest:

* Allow for between 2 - 4 hours to complete this, however time is not important
but rather quality.
* Tests.)

## Deliverables
* A git bundle containing your source file, test data and test code
  * How to git bundle:
  * `git bundle create <your_name>.bundle master` inside your code repo

## API

You may use the CoinJar Exchange ticker API. The endpoints you will need are:

* https://data.exchange.coinjar.com/products/BTCAUD/ticker
* https://data.exchange.coinjar.com/products/ETHAUD/ticker

## Example response
```{
  "volume_24h": "83.85000000",
  "volume": "19.71000000",
  "transition_time": "2018-06-21T07:50:00Z",
  "status": "continuous",
  "session": 3190,
  "prev_close": "9211.00000000",
  "last": "9210.00000000",
  "current_time": "2018-06-21T02:08:23.832377Z",
  "bid": "9211.00000000",
  "ask": "9242.00000000"
}```
