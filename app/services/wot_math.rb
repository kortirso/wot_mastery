# frozen_string_literal: true

module WotMath
  def mean(sum, elements_amount)
    elements_amount.zero? ? 0 : (sum / elements_amount)
  end

  def array_to_matrix(array)
    Matrix[*array]
  end
end
