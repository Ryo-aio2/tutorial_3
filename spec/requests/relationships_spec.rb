require 'rails_helper'

RSpec.describe 'Relationships', type: :request do
  describe '#create' do
    let(:user) { FactoryBot.create(:user) }
    let(:other) { FactoryBot.create(:user, :other_user) }

    context 'ログイン状態の場合' do
      it '1件増えること' do
        log_in user
        expect do
          post relationships_path, params: { followed_id: other.id }
        end.to change(Relationship, :count).by 1
      end

      it 'Ajaxでも登録できること' do
        log_in user
        expect do
          post relationships_path, params: { followed_id: other.id }, xhr: true
        end.to change(Relationship, :count).by 1
      end
    end

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

  describe '#destroy' do
    let(:user) { FactoryBot.create(:user) }
    let(:other) { FactoryBot.create(:user, :other_user) }

    it '1件減ること' do
      log_in user
      user.follow(other)
      relationship = user.active_relationships.find_by(followed_id: other.id)
      expect do
        delete relationship_path(relationship)
      end.to change(Relationship, :count).by(-1)
    end

    it 'Ajaxでも削除できること' do
      log_in user
      user.follow(other)
      relationship = user.active_relationships.find_by(followed_id: other.id)
      expect do
        delete relationship_path(relationship), xhr: true
      end.to change(Relationship, :count).by(-1)
    end
  end
end
