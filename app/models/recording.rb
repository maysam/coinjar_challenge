# frozen_string_literal: true

class Recording < ApplicationRecord
  scope :BTC, -> { where(product: 'BTCAUD') }
  scope :ETH, -> { where(product: 'ETHAUD') }
end
