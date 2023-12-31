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
require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) do
    described_class.new(name: 'Example User',
                        email: 'user@example.com',
                        password: 'foobar',
                        password_confirmation: 'foobar')
  end

  it 'userが有効であること' do
    expect(user).to be_valid
  end

  it 'nameが必須であること' do
    user.name = ''
    expect(user).not_to be_valid
  end

  it 'nameは50文字以内であること' do
    user.name = 'a' * 51
    expect(user).not_to be_valid
  end

  it 'emailが必須であること' do
    user.email = ''
    expect(user).not_to be_valid
  end

  it 'emailは255文字以内であること' do
    user.email = "#{'a' * 244}@example.com"
    expect(user).not_to be_valid
  end

  it 'emailが有効な形式であること' do
    valid_addresses = %w[user@exmple.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      user.email = valid_address
      expect(user).to be_valid
    end
  end

  it '無効な形式のemailは失敗すること' do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      user.email = invalid_address
      expect(user).not_to be_valid
    end
  end

  it 'emailは重複して登録できないこと' do
    duplicate_user = user.dup
    duplicate_user.email = user.email.upcase
    user.save
    expect(duplicate_user).not_to be_valid
  end

  it 'emailは小文字でDB登録されていること' do
    mixed_case_email = 'Foo@ExAMPle.CoM'
    user.email = mixed_case_email
    user.save
    expect(user.reload.email).to eq mixed_case_email.downcase
  end

  it 'passwordが必須であること' do
    user.password = user.password_confirmation = ' ' * 6
    expect(user).not_to be_valid
  end

  it 'passwordは6文字以上であること' do
    user.password = user.password_confirmation = 'a' * 5
    expect(user).not_to be_valid
  end

  describe '#authenticated?' do
    it 'digestがnilならfalseを返すこと' do
      expect(user.authenticated?(:remember, '')).to be(false)
    end
  end
end
