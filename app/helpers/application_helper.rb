# frozen_string_literal: true

module ApplicationHelper
  def as_money(centformat)
    format('%.2f', (centformat.to_f / 100))
  end
end
