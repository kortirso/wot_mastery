# frozen_string_literal: true

module Api
  module V1
    class TanksController < Api::V1::BaseController
      before_action :tanks

      def index
        render json: { tanks: TankSerializer.new(@tanks).serializable_hash }, status: :ok
      end

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
  end
end
