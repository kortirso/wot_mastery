# frozen_string_literal: true

module Tanks
  class ExperienceCoefficientsCalculationJob < ApplicationJob
    queue_as :default

    def perform
      Tank.all.each do |tank|
        Tanks::ExperienceCoefficients.new(object: tank).call
      end

      Tanks::Type.all.each do |tanks_type|
        Tanks::ExperienceCoefficients.new(object: tanks_type).call
      end
    end
  end
end
