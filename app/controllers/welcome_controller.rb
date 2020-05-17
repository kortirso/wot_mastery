# frozen_string_literal: true

class WelcomeController < ApplicationController
  before_action :countries
  before_action :tanks
  before_action :tank_types_filter_values

  def index; end

  private

  def countries
    @countries = Country.order(id: :asc)
  end

  def tanks
    @tanks = Tank.order(id: :asc)
  end

  def tank_types_filter_values
    @tank_types_filter_values = [
      %w[light Light\ tanks],
      %w[medium Medium\ tanks],
      %w[heavy Heavy\ tanks],
      %w[destroyer Tank\ destroyers],
      %w[spg SPGs]
    ]
  end
end
