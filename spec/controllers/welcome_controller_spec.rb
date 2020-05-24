# frozen_string_literal: true

RSpec.describe WelcomeController, type: :controller do
  describe 'GET#index' do
    it 'renders index template' do
      get :index, params: { locale: 'en' }

      expect(response).to render_template :index
    end
  end
end
