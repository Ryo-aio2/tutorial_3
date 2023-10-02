# == Schema Information
#
# Table name: users
#
#  id                :bigint           not null, primary key
#  activated         :boolean          default(FALSE)
#  activated_at      :datetime
#  activation_digest :string
#  admin             :boolean          default(FALSE), not null
#  email             :string           not null
#  name              :string           not null
#  password_digest   :string           not null
#  remember_digest   :string
#  reset_digest      :string
#  reset_sent_at     :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
FactoryBot.define do
  factory :user, aliases: %i[followed follower] do
    sequence(:name) { |n| "Example User #{n}" }
    sequence(:email) { |n| "example-#{n}@gmail.com" }
    password { 'password' }
    password_confirmation { 'password' }
    admin { false }
    activated { true }
    activated_at { Time.zone.now }

    trait :admin_user do
      admin { true }
    end

    trait :other_user do
      name { 'Sterling Archer' }
      email { 'duchess@example.gov' }
    end

    trait :with_relationships do
      after(:create) do |user|
        30.times do
          other_user = create(:user)
          user.follow(other_user)
          other_user.follow(user)
        end
      end
    end

    trait :with_posts do
      after(:create) { |user| create_list(:micropost, 31, user: user) }
    end
  end

  factory :continuous_users, class: 'User' do
    sequence(:name) { |n| "User #{n}" }
    sequence(:email) { |n| "user-#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    admin { false }
    activated { true }
    activated_at { Time.zone.now }
  end
end
