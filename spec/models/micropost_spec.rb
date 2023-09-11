# == Schema Information
#
# Table name: microposts
#
#  id         :bigint           not null, primary key
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_microposts_on_user_id                 (user_id)
#  index_microposts_on_user_id_and_created_at  (user_id,created_at)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Micropost, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:micropost) { Micropost.new(content: 'Lorem ipsum', user_id: user.id) }

  it '有効であること' do
    expect(micropost).to be_valid
  end

  it 'user_idがない場合は、無効であること' do
    micropost.user_id = nil
    expect(micropost).to_not be_valid
  end

  describe 'content' do
    it '空なら無効であること' do
      micropost.content = '    '
      expect(micropost).to_not be_valid
    end

    it '141文字以上なら無効であること' do
      micropost.content = 'a' * 141
      expect(micropost).to_not be_valid
    end
  end

  it '並び順は投稿の新しい順になっていること' do
    FactoryBot.send(:user_with_posts)
    expect(FactoryBot.create(:most_recent)).to eq Micropost.first
  end
end
