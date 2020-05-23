# frozen_string_literal: true

class WelcomeController < ApplicationController
  before_action :countries
  before_action :tanks
  before_action :tanks_types

  def index; end

  private

  def countries
    @countries = Country.order(id: :asc)
  end

  def tanks
    @tanks = Tank.order(id: :asc).includes(:tanks_type)
  end

  def tanks_types
    @tanks_types = Tanks::Type.order(id: :asc)
  end
end
