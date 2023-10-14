require 'swagger_helper'

describe 'Posts API' do
  let(:user) { create(:user) }
  let(:auth_headers) { user.create_new_auth_token }

  path '/users/{user_id}/posts' do
    get 'Retrieves all posts for a user' do
      tags 'Posts'
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :integer

      let(:user_id) { user.id }

      response '200', 'OK' do
        let(:Authorization) { auth_headers['access-token'] }

        run_test!
      end

      response '401', 'Unauthorized' do
        let(:Authorization) { nil }

        run_test!
      end
    end
  end
end
