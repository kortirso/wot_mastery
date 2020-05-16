# frozen_string_literal: true

class WelcomeController < ApplicationController
  before_action :countries
  before_action :tanks

  def index; end

  private

  def countries
    @countries = Country.order(id: :asc)
  end

  def tanks
    @tanks = Tank.order(id: :asc)
  end
end
