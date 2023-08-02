require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /signup' do
    it 'returns http success' do
      get signup_path
      expect(response).to have_http_status(:ok)
    end

    it 'Sign up | Ruby on Rails Tutorial Sample Appが含まれること' do
      get signup_path
      expect(response.body).to include full_title('Sign up')
    end
  end

  describe 'POST /users #create' do
    it '無効な値だと登録されないこと' do
      expect do
        post users_path, params: { user: { name: '',
                                           email: 'user@invlid',
                                           password: 'foo',
                                           password_confimation: 'bar' } }
      end.to_not change(User, :count)
    end
  end
end
