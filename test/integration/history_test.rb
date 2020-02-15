# frozen_string_literal: true

require 'test_helper'

class HistoryTest < ActionDispatch::IntegrationTest
  test 'list the all the captured prices for the selected product' do
    get "/history/#{recordings(:btc).product}"

    assert_select 'h1', "#{recordings(:btc).product} history"
    assert_select 'a', 'Back' do
      assert_select '[href=?]', root_url
    end

    assert_select 'table' do
      assert_select 'tr', count: 2

      assert_select 'thead tr' do
        assert_select 'th', count: 4

        assert_select 'th:nth-child(1)', 'Last'
        assert_select 'th:nth-child(2)', 'Bid'
        assert_select 'th:nth-child(3)', 'Ask'
        assert_select 'th:nth-child(4)', 'Recorded At'
      end

      assert_select 'tbody' do
        assert_select 'tr:nth-child(1)' do
          assert_select 'td:nth-child(1)', as_money(recordings(:btc).last)
          assert_select 'td:nth-child(2)', as_money(recordings(:btc).bid)
          assert_select 'td:nth-child(3)', as_money(recordings(:btc).ask)
          assert_select 'td:nth-child(4)', recordings(:btc).created_at.to_s
        end
      end
    end
  end

  test 'history of captured prices of a currency in descending order by time' do
    get "/history/#{recordings(:btc).product}"

    assert_select 'table' do
      assert_select 'tr:nth-child(1)' do
        assert_select 'td:nth-child(1)', as_money(recordings(:btc).last)
        assert_select 'td:nth-child(2)', as_money(recordings(:btc).bid)
        assert_select 'td:nth-child(3)', as_money(recordings(:btc).ask)
        assert_select 'td:nth-child(4)', recordings(:btc).created_at.to_s
      end
    end

    body_btc = {
      "last": '19210.00000000',
      "bid": '19211.00000000',
      "ask": '19242.00000000',
      'created_at': Time.now
    }
    stub_request(:get, 'https://data.exchange.coinjar.com/products/BTCAUD/ticker')
      .to_return(body: body_btc.to_json)
    body_eth = {
      "last": '19210.00000000',
      "bid": '19211.00000000',
      "ask": '19242.00000000'
    }
    stub_request(:get, 'https://data.exchange.coinjar.com/products/ETHAUD/ticker')
      .to_return(body: body_eth.to_json)

    post capture_url

    get "/history/#{recordings(:btc).product}"

    assert_select 'table' do
      assert_select 'tr:nth-child(1)' do
        assert_select 'td:nth-child(1)', as_money(body_btc[:last])
        assert_select 'td:nth-child(2)', as_money(body_btc[:bid])
        assert_select 'td:nth-child(3)', as_money(body_btc[:ask])
        assert_select 'td:nth-child(4)', body_btc[:created_at].utc.to_s
      end
    end
  end
end
