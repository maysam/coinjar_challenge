# frozen_string_literal: true

require 'json'

class HistoryController < ApplicationController
  COINJAR_FETCH_URL = 'https://data.exchange.coinjar.com/products/%s/ticker'

  def capture
    %w[BTCAUD ETHAUD].each do |product|
      url = URI.parse(COINJAR_FETCH_URL % product)
      result = Net::HTTP.get(url)
      data = JSON.parse(result)
      Rails.logger.info result
      Rails.logger.info data
      product_values = data.slice('last', 'bid', 'ask')
      Recording
        .where(product: product)
        .create product_values.stringify_keys
    end
  rescue StandardError => err
    flash[:alert] = err.message
  ensure
    redirect_to root_url
  end

  def index
    latest_recordings_ids = Recording.group(:product).maximum(:id).values
    @latest_recordings = Recording.find latest_recordings_ids
  end

  def history
    @product = params[:product]
    @recordings = Recording.order(id: :desc).where product: @product
  end
end
