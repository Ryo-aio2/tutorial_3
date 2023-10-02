require 'rails_helper'

RSpec.describe 'Relationships', type: :request do
  describe '#create' do
    context '未ログインの場合' do
      it 'ログインページにリダイレクトすること' do
        post relationships_path
        expect(response).to redirect_to login_path
      end

      it '登録されないこと' do
        expect do
          post relationships_path
        end.not_to change(Relationship, :count)
      end
    end
  end
end
