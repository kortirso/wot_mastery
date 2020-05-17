# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController
      protect_from_forgery with: :null_session

      before_action :set_locale

      private

      def set_locale
        I18n.locale = params[:locale] || :en
      end
    end
  end
end
