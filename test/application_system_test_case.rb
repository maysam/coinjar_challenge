# frozen_string_literal: true

require 'test_helper'
WebMock.allow_net_connect!
class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :rack_test
  setup do    
	  p '1:'
p page.driver.class
WebMock.allow_net_connect!
    stub_request(:get, %r|chromedriver.storage.googleapis.com|)
      .to_return(status: 200, body: '', headers: {})
  
	stub_request(:get, "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_80.0.3987").
	  with(
	    headers: {
		  'Accept'=>'*/*',
		  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
		  'Host'=>'chromedriver.storage.googleapis.com',
		  'User-Agent'=>'Ruby'
	    }).
	  to_return(status: 200, body: "", headers: {})
  end
end
