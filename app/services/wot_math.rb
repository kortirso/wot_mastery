# frozen_string_literal: true

module WotMath
  def mean(sum, elements_amount)
    elements_amount.zero? ? 0 : (sum / elements_amount)
  end
end
