require 'rails_helper'

RSpec.describe 'Microposts', type: :request do
  describe 'POST /microposts' do
    context '未ログインの場合' do
      it '/loginにリダイレクトすること' do
        post microposts_path, params: { micropost: { context: 'Test post' } }
        expect(response).to redirect_to login_path
      end

      it 'postが作成されていないこと' do
        expect do
          post microposts_path, params: { micropost: { context: 'Test post' } }
        end.not_to change(Micropost, :count)
      end
    end
  end

  describe 'DELETE /microposts/id' do
    let(:user) { FactoryBot.create(:user) }
    let!(:micropost) { FactoryBot.create(:micropost) }

    context '他のユーザーの投稿を削除した場合' do
      before do
        log_in user
      end

      it '削除されないこと' do
        expect do
          delete micropost_path(micropost)
        end.not_to change(Micropost, :count)
      end

      it 'ログインページにリダイレクトされること' do
        delete micropost_path(micropost)
        expect(response).to redirect_to root_url
      end
    end

    context '未ログインの場合' do
      it '/loginにリダイレクトすること' do
        delete micropost_path(micropost)
        expect(response).to redirect_to login_path
      end

      it 'postが削除されないこと' do
        expect do
          delete micropost_path(micropost)
        end.not_to change(Micropost, :count)
      end
    end
  end
end
