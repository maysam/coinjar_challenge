# frozen_string_literal: true

require 'test_helper'
WebMock.allow_net_connect!

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :rack_test
end
