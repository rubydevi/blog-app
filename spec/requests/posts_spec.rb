require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  context 'GET /users/123/posts' do
    it 'renders a successful response' do
      get user_posts_path(123)
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get user_posts_path(123)
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder text in the response body' do
      get user_posts_path(123)
      expect(response.body).to include('Here is a list of posts for a given user')
    end
  end

  context 'GET /users/123/posts/1' do
    it 'renders a successful response' do
      get user_post_path(123, 1)
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      get user_post_path(123, 1)
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder text in the response body' do
      get user_post_path(123, 1)
      expect(response.body).to include('Here is a selected post from posts')
    end
  end
end
