require 'rails_helper'

RSpec.describe 'Microposts', type: :request do
  describe 'POST /microposts' do
    context 'ログインしている場合' do
    end

    context '未ログインの場合' do
      it '/loginにリダイレクトすること' do
        post microposts_path, params: { micropost: { context: 'Test post' } }
        expect(response).to redirect_to login_path
      end

      it 'postが作成されていないこと' do
        expect do
          post microposts_path, params: { micropost: { context: 'Test post' } }
        end.to_not change(Micropost, :count)
      end
    end
  end

  describe 'DELETE /microposts/id' do
    let(:user) { FactoryBot.create(:user) }
    let!(:micropost) { FactoryBot.create(:micropost) }

    context 'ログインしている場合' do
    end

    context '未ログインの場合' do
      it '/loginにリダイレクトすること' do
        delete micropost_path(micropost)
        expect(response).to redirect_to login_path
      end

      it 'postが削除されないこと' do
        expect do
          delete micropost_path(micropost)
        end.to_not change(Micropost, :count)
      end
    end
  end
end
