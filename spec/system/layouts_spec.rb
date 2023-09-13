require 'rails_helper'

RSpec.describe 'Layouts', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user) { FactoryBot.create(:user) }

  describe 'header' do
    context 'ログイン済みの場合' do
      before do
        log_in user
        visit root_path
      end

      it 'titleをクリックするとrootに遷移すること' do
        click_link 'sample app'
        expect(page).to have_current_path root_path, ignore_query: true
      end

      it 'Homeをクリックするとrootに遷移すること' do
        click_link 'Home'
        expect(page).to have_current_path root_path, ignore_query: true
      end

      it 'HelpをクリックするとHelpページに遷移すること' do
        click_link 'Help'
        expect(page).to have_current_path help_path, ignore_query: true
      end

      it 'Usersをクリックするとユーザ一覧ページに遷移すること' do
        click_link 'Users'
        expect(page).to have_current_path users_path, ignore_query: true
      end

      # rubocop:disable RSpec/NestedGroups
      context 'Account' do
        before do
          click_link 'Account'
        end

        it 'Profileをクリックするとユーザ詳細ページに遷移すること' do
          click_link 'Profile'
          expect(page).to have_current_path user_path(user), ignore_query: true
        end

        it 'Settingsをクリックするとユーザ編集ページに遷移すること' do
          click_link 'Settings'
          expect(page).to have_current_path edit_user_path(user), ignore_query: true
        end

        it 'Log outをクリックするとログアウトしてrootにリダイレクトすること' do
          click_link 'Log out'
          expect(page).to have_current_path root_path, ignore_query: true
        end
      end
      # rubocop:enable RSpec/NestedGroups
    end

    context '未ログインの場合' do
      before do
        visit root_path
      end

      it 'Homeをクリックするとrootに遷移すること' do
        click_link 'Home'
        expect(page).to have_current_path root_path, ignore_query: true
      end

      it 'HelpをクリックするとHelpページに遷移すること' do
        click_link 'Help'
        expect(page).to have_current_path help_path, ignore_query: true
      end

      it 'Log inをクリックするとログインページに遷移すること' do
        click_link 'Log in'
        expect(page).to have_current_path login_path, ignore_query: true
      end
    end
  end

  describe 'footer' do
    context 'ログイン済みの場合' do
      before do
        log_in user
        visit root_path
      end

      it 'Aboutをクリックするとaboutページに遷移すること' do
        click_link 'About'
        expect(page).to have_current_path about_path, ignore_query: true
      end

      it 'Contactをクリックするとcontactページに遷移すること' do
        click_link 'Contact'
        expect(page).to have_current_path contact_path, ignore_query: true
      end
    end

    context '未ログインの場合' do
      before do
        visit root_path
      end

      it 'Aboutをクリックするとaboutページに遷移すること' do
        click_link 'About'
        expect(page).to have_current_path about_path, ignore_query: true
      end

      it 'Contactをクリックするとcontactページに遷移すること' do
        click_link 'Contact'
        expect(page).to have_current_path contact_path, ignore_query: true
      end
    end
  end
end
