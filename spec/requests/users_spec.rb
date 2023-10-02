require 'rails_helper'

RSpec.describe 'Users', type: :request do
  context 'GET /users' do
    it 'renders a successful response' do
      get users_path
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get users_path
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder text in the response body' do
      get users_path
      expect(response.body).to include('Here is a list of users')
    end
  end

  context 'GET /users/123' do
    it 'renders a successful response' do
      get user_path(123)
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      get user_path(123)
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder text in the response body' do
      get user_path(123)
      expect(response.body).to include('Here is a selected user from users list')
    end
  end
end
