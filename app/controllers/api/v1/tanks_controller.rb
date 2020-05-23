# frozen_string_literal: true

module Api
  module V1
    class TanksController < Api::V1::BaseController
      before_action :tanks

      def index
        render json: { tanks: TankSerializer.new(@tanks).serializable_hash }, status: :ok
      end

      private

      # rubocop: disable Metrics/AbcSize
      def tanks
        @tanks =
          Tank
            .includes(:country, :experience_coefficient, :tanks_type)
            .order(tier: :asc, country_id: :asc)
            .order('tanks_types.name ASC')

        @tanks = @tanks.where(country_id: parse_params(params[:country_ids])) if params[:country_ids]
        @tanks = @tanks.where(tanks_type_id: parse_params(params[:type_ids])) if params[:type_ids]
        @tanks = @tanks.where(tiers: parse_params(params[:tiers])) if params[:tiers]
        @tanks = @tanks.where(id: parse_params(params[:tank_ids])) if params[:tank_ids]
      end
      # rubocop: enable Metrics/AbcSize

      def parse_params(param)
        param.split(',').map(&:to_i)
      end
    end
  end
end
