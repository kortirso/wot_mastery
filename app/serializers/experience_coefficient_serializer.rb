# frozen_string_literal: true

class ExperienceCoefficientSerializer
  include FastJsonapi::ObjectSerializer

  set_type :tanks_experience_coefficient
  attributes :bonus, :kill, :damage, :assist, :block, :stun
end
