# frozen_string_literal: true

require 'test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :rack_test
  Capybara.default_driver = :rack_test
  setup do
    stub_request(:get, /chromedriver.storage.googleapis.com/)
      .to_return(status: 200, body: '', headers: {})
  end
end
