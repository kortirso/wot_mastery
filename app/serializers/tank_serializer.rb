# frozen_string_literal: true

class TankSerializer
  include FastJsonapi::ObjectSerializer

  MASTER_GRADE_QUALITY = 99
  FIRST_GRADE_QUALITY = 95

  set_type :tank
  attributes :name, :tier
  attribute :master_grade_boundary, &:master_boundary

  attribute :experience_coefficient do |object|
    ExperienceCoefficientSerializer.new(object.experience_coefficient).serializable_hash
  end

  attribute :type do |object|
    object.tanks_type.name
  end

  attribute :country_name do |object|
    object.country.name
  end

  attribute :damage_for_master do |object|
    damage_for_master(object)
  end

  attribute :damage_for_master_per_shots do |object|
    damage_for_master(object) / object.damage_per_shot
  end

  attribute :damage_for_master_by_health do |object|
    damage_for_master(object) / object.health
  end

  attribute :first_grade_boundary do |object|
    object.master_boundary * FIRST_GRADE_QUALITY / MASTER_GRADE_QUALITY
  end

  attribute :coefficient_precision do |object|
    object.experience_coefficient.precision / 10.0
  end

  def self.damage_for_master(object)
    return @damage_for_master if @current_object == object

    @current_object = object
    @damage_for_master =
      (1000 * object.master_boundary - object.experience_coefficient.bonus) / object.experience_coefficient.damage
  end
end
