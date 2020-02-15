# frozen_string_literal: true

require 'test_helper'

class HomepageTest < ActionDispatch::IntegrationTest
  test 'contains a button to capture latest prices' do
    get '/'

    assert_select 'h2', 'Latest currency prices'

    assert_select 'form' do
      assert_select '[method=?]', 'post'
      assert_select '[action=?]', capture_url
      assert_select 'input' do
        assert_select '[value=?]', 'Capture'
      end
    end
  end

  test 'lists currencies and their latest prices' do
    get '/'

    assert_select 'table' do
      assert_select 'tr', count: 3

      assert_select 'thead tr:first-child' do
        assert_select 'th', count: 5

        assert_select 'th:nth-child(1)', 'Currency'
        assert_select 'th:nth-child(2)', 'Last'
        assert_select 'th:nth-child(3)', 'Bid'
        assert_select 'th:nth-child(4)', 'Ask'
        assert_select 'th:nth-child(5)', 'Updated At'
      end

      assert_select 'tbody tr:nth-child(1)' do
        assert_select 'td:nth-child(1)' do
          assert_select 'a', recordings(:btc).product do
            assert_select '[href=?]', history_url(recordings(:btc).product)
          end
        end

        assert_select 'td', as_money(recordings(:btc).last)
        assert_select 'td:nth-child(2)', as_money(recordings(:btc).last)
        assert_select 'td:nth-child(3)', as_money(recordings(:btc).bid)
        assert_select 'td:nth-child(4)', as_money(recordings(:btc).ask)
        assert_select 'td:nth-child(5)', recordings(:btc).created_at.to_s
      end

      assert_select 'tbody tr:nth-child(2)' do
        assert_select 'td:nth-child(1)' do
          assert_select 'a', recordings(:eth).product do
            assert_select '[href=?]', history_url(recordings(:eth).product)
          end
        end

        assert_select 'td:nth-child(2)', as_money(recordings(:eth).last)
        assert_select 'td:nth-child(3)', as_money(recordings(:eth).bid)
        assert_select 'td:nth-child(4)', as_money(recordings(:eth).ask)
        assert_select 'td:nth-child(5)', recordings(:eth).created_at.to_s
      end
    end
  end
end
