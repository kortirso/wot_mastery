# frozen_string_literal: true

module Tanks
  class ExperienceCoefficientsCalculationJob < ApplicationJob
    queue_as :default

    def perform
      Tank.all.each do |tank|
        Tanks::ExperienceCoefficients.new(tank: tank).call
      end
    end
  end
end
