FactoryBot.define do
    factory :user do
      name { 'Michael Example' }
      email { 'michael@example.com' }
      password { 'password' }
      password_confirmation { 'password' }
    end
  end