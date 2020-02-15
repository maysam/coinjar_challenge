# frozen_string_literal: true

require 'application_system_test_case'

class HistoryTest < ApplicationSystemTestCase
  test 'visiting the index' do
    stub_request(:post, 'www.example.com')
      .with(body: 'abc', headers: { 'Content-Length' => 3 })
    visit trumps_url

    assert_selector 'h1', text: 'Trump'
  end
end
