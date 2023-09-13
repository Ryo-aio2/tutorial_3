require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  let(:user) { FactoryBot.create(:user) }

  describe 'account_activation' do
    let(:mail) { described_class.account_activation(user) }

    before do
      user.activation_token = User.new_token
    end

    it '"Account activation"というタイトルで送信されること' do
      expect(mail.subject).to eq('Account activation')
    end

    it '送信先が"to@example.org"であること' do
      expect(mail.to).to eq([user.email])
    end

    it '送信元が"from@example.com"であること' do
      expect(mail.from).to eq(['noreply@example.com'])
    end

    it 'メール本文にユーザ名が表示されていること' do
      expect(mail.body.encoded).to match(user.name)
    end

    it 'メール本文にユーザのactivation_tokenが表示されていること' do
      expect(mail.body.encoded).to match(user.activation_token)
    end

    it 'メール本文にユーザのemailが表示されていること' do
      expect(mail.body.encoded).to match(CGI.escape(user.email))
    end
  end

  describe 'password_reset' do
    let(:mail) { described_class.password_reset(user) }

    before do
      user.reset_token = User.new_token
    end

    it '"Password reset"というタイトルで送信されること' do
      expect(mail.subject).to eq('Password reset')
    end

    it '送信先が"to@example.org"であること' do
      expect(mail.to).to eq([user.email])
    end

    it '送信元が"from@example.com"であること' do
      expect(mail.from).to eq(['noreply@example.com'])
    end

    it 'メール本文にreset_tokenが表示されていること' do
      expect(mail.body.encoded).to match(user.reset_token)
    end

    it 'メール本文にユーザのemailが表示されていること' do
      expect(mail.body.encoded).to match(CGI.escape(user.email))
    end
  end
end
