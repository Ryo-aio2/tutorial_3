# == Schema Information
#
# Table name: relationships
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  followed_id :integer          not null
#  follower_id :integer          not null
#
# Indexes
#
#  index_relationships_on_followed_id                  (followed_id)
#  index_relationships_on_follower_id                  (follower_id)
#  index_relationships_on_follower_id_and_followed_id  (follower_id,followed_id) UNIQUE
#
require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe 'validationテスト' do
    let(:relationship) { FactoryBot.create(:relationship) }

    context '無効な属性を持つ場合' do
      it 'follower_idがないと無効になること' do
        relationship.follower_id = nil
        expect(relationship).not_to be_valid
      end

      it 'followed_idがないと無効になること' do
        relationship.followed_id = nil
        expect(relationship).not_to be_valid
      end
    end
  end
end
