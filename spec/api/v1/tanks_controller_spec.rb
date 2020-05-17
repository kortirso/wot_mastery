# frozen_string_literal: true

RSpec.describe Api::V1::TanksController do
  describe 'GET#index' do
    before do
      tank = create :tank
      create :tank_experience_coefficient, tank: tank

      get '/api/v1/tanks.json', params: { tank_ids: tank.id }
    end

    it 'returns status 200' do
      expect(response.status).to eq 200
    end

    %w[
      name type tier country_name damage_for_master damage_for_master_per_shots
      damage_for_master_by_health master_grade_boundary first_grade_boundary
    ].each do |attr|
      it "and contains tanks #{attr}" do
        expect(response.body).to have_json_path("tanks/data/0/attributes/#{attr}")
      end
    end
  end
end
