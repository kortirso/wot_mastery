# frozen_string_literal: true

module Tanks
  class MasteryBorderCalculationJob < ApplicationJob
    queue_as :default

    def perform
      Tank.all.each do |tank|
        Tanks::MasteryBorder.new(tank: tank).call
      end
    end
  end
end
