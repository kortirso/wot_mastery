# frozen_string_literal: true

class TanksController < ApplicationController
  before_action :tanks

  def index; end

  private

  def tanks
    tank_ids = params[:tank_ids]&.split(',')&.map(&:to_i)
    @tanks =
      Tank
        .where(id: tank_ids)
        .order(tier: :asc, country_id: :asc, type: :asc)
        .includes(:country, :experience_coefficient)
  end
end
