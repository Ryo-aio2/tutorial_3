RSpec.describe 'Users', type: :system do
  before do
    driven_by(:rack_test)
  end

  describe '#create' do
    context '無効な値の場合' do
      it 'エラーメッセージ用の表示領域が描画されていること' do
        visit signup_path
        fill_in 'Name', with: ''
        fill_in 'Email', with: 'user@invlid'
        fill_in 'Password', with: 'foo'
        fill_in 'Confirmation', with: 'bar'
        click_button 'Create my account'

        expect(page).to have_selector 'div#error_explanation'
        expect(page).to have_selector 'div.field_with_errors'
      end
    end
  end

  describe '#index' do
    let!(:admin) { FactoryBot.create(:user, :admin_user) }
    let!(:not_admin) { FactoryBot.create(:user, :other_user) }

    it 'adminユーザならdeleteリンクが表示されること' do
      log_in admin
      visit users_path

      expect(page).to have_link 'delete'
    end

    it 'adminユーザでなければdeleteリンクが表示されないこと' do
      log_in not_admin
      visit users_path

      expect(page).not_to have_link 'delete'
    end

    describe 'following and followers' do
      let(:user_with_relationships) { FactoryBot.create(:user, :with_relationships) }
      let(:following) { user_with_relationships.following.count }
      let(:followers) { user_with_relationships.followers.count }

      it 'followingとfollowersが正しく表示されること' do
        log_in user_with_relationships
        expect(page).to have_content("#{following} following")
        expect(page).to have_content("#{followers} followers")
      end
    end
  end

  describe 'GET /users/id/following' do
    let(:user) { FactoryBot.create(:user) }

    context 'ログイン状態の場合' do
      before do
        @user_with_relationships = FactoryBot.create(:user, :with_relationships)
        @following = @user_with_relationships.following
        log_in @user_with_relationships
      end

      it 'followingの数とフォローしているユーザへのリンクが表示されていること' do
        visit following_user_path(@user_with_relationships)

        # ここが空の場合後のテストが実行されないため
        expect(@following).not_to be_empty

        expect(page).to have_content("#{@following.count} following")
        @following.paginate(page: 1).each do |follow|
          expect(page).to have_link follow.name, href: user_path(follow)
        end
      end
    end
  end

  describe 'GET /users/id/followers' do
    let(:user) { FactoryBot.create(:user) }

    context 'ログイン状態の場合' do
      before do
        @user_with_relationships = FactoryBot.create(:user, :with_relationships)
        @followers = @user_with_relationships.followers
        log_in @user_with_relationships
      end

      it 'followersの数とフォローしているユーザへのリンクが表示されていること' do
        visit followers_user_path(@user_with_relationships)

        # ここが空の場合後のテストが実行されないため
        expect(@followers).not_to be_empty

        expect(page).to have_content("#{@followers.count} followers")
        @followers.paginate(page: 1).each do |follower|
          expect(page).to have_link follower.name, href: user_path(follower)
        end
      end
    end
  end
end
