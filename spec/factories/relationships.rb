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
FactoryBot.define do
  factory :relationship do
    association :followed
    association :follower
  end

  def create_relationships
    FactoryBot.create_list(:continuous_users, 10)

    FactoryBot.create(:user) do |user|
      User.all[0...-1].each do |other|
        FactoryBot.create(:follower, follower_id: other.id, followed_id: user.id)
        FactoryBot.create(:following, follower_id: user.id, followed_id: other.id)
      end
      user
    end
  end
end
