# frozen_string_literal: true

require 'test_helper'

class HistoryControllerTest < ActionDispatch::IntegrationTest
  test 'should capture data via coinjar api' do
    body_btc = {
      "last": '9210.00000000',
      "bid": '9211.00000000',
      "ask": '9242.00000000'
    }
    stub_request(:get, 'https://data.exchange.coinjar.com/products/BTCAUD/ticker')
      .to_return(body: body_btc.to_json)
    body_eth = {
      "last": '9210.00000000',
      "bid": '9211.00000000',
      "ask": '9242.00000000'
    }
    stub_request(:get, 'https://data.exchange.coinjar.com/products/ETHAUD/ticker')
      .to_return(body: body_eth.to_json)

    assert_difference('Recording.count', 2) do
      post capture_url
    end

    assert_equal Recording.BTC.last.last, body_btc[:last]
    assert_equal Recording.BTC.last.bid, body_btc[:bid]
    assert_equal Recording.BTC.last.ask, body_btc[:ask]

    assert_equal Recording.ETH.last.last, body_eth[:last]
    assert_equal Recording.ETH.last.bid, body_eth[:bid]
    assert_equal Recording.ETH.last.ask, body_eth[:ask]

    assert_redirected_to root_url
  end

  test 'should get index' do
    get root_url
    assert_response :success
  end

  test 'should get history' do
    get history_url(recordings(:btc))
    assert_response :success
  end
end
