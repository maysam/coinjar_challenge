# frozen_string_literal: true

require 'application_system_test_case'

class ChallengeTest < ApplicationSystemTestCase
  test 'homepage has latest prices for each currency' do
    visit root_url

    assert_selector 'h2', text: 'Latest currency prices'

    within 'table' do
      within 'thead' do
        within 'tr' do
          assert_selector 'th', text: 'Currency'
          assert_selector 'th', text: 'Last'
          assert_selector 'th', text: 'Bid'
          assert_selector 'th', text: 'Ask'
          assert_selector 'th', text: 'Updated At'
        end
      end

      within 'tbody' do
        within 'tr:first' do
          assert_selector 'td', text: recordings(:btc).product
          assert_selector 'td', text: as_money(recordings(:btc).last)
          assert_selector 'td', text: as_money(recordings(:btc).bid)
          assert_selector 'td', text: as_money(recordings(:btc).ask)
          assert_selector 'td', text: recordings(:btc).created_at.utc
        end

        within 'tr:nth-child(2)' do
          assert_selector 'td', text: recordings(:eth).product
          assert_selector 'td', text: as_money(recordings(:eth).last)
          assert_selector 'td', text: as_money(recordings(:eth).bid)
          assert_selector 'td', text: as_money(recordings(:eth).ask)
          assert_selector 'td', text: recordings(:eth).created_at.utc
        end
      end
    end
  end

  test 'capturing new data should update homepage' do
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

    visit root_url

    # capturing new data should update homepage
    click_button 'Capture'

    assert_current_path root_url

    within 'table' do
      within 'tbody' do
        within 'tr:first' do
          assert_selector 'td', text: 'BTCAUD'
          assert_selector 'td', text: as_money(body_btc[:last])
          assert_selector 'td', text: as_money(body_btc[:bid])
          assert_selector 'td', text: as_money(body_btc[:ask])
          assert_selector 'td', text: body_btc['created_at']
        end
      end
    end

    # click on currency and history of prices is listed in descending order by time
    click_link 'BTCAUD'

    assert_current_path history_url('BTCAUD')

    assert_selector 'h2', text: 'BTCAUD history'

    within 'table' do
      within 'thead' do
        within 'tr' do
          assert_selector 'th', text: 'Last'
          assert_selector 'th', text: 'Bid'
          assert_selector 'th', text: 'Ask'
          assert_selector 'th', text: 'Recorded At'
        end
      end

      within 'tbody' do
        within 'tr:first' do
          assert_selector 'td', text: as_money(body_btc[:last])
          assert_selector 'td', text: as_money(body_btc[:bid])
          assert_selector 'td', text: as_money(body_btc[:ask])
          assert_selector 'td', text: body_btc['created_at']
        end

        within 'tr:nth-child(2)' do
          assert_selector 'td', text: as_money(recordings(:btc).last)
          assert_selector 'td', text: as_money(recordings(:btc).bid)
          assert_selector 'td', text: as_money(recordings(:btc).ask)
          assert_selector 'td', text: recordings(:btc).created_at.utc
        end
      end
    end

    # click back to go to homepage
    click_link 'Back'
    assert_current_path root_url
  end
end
