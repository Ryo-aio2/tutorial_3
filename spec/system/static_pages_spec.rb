RSpec.describe 'StaticPages', type: :system do
  before do
    driven_by(:rack_test)
  end

  describe 'root' do
    it 'root_pathへのリンクが2つ、help, about, contactへのリンクが表示されていること' do
      visit root_path
      link_to_root = page.find_all("a[href=\"#{root_path}\"]")

      expect(link_to_root.size).to eq 2
      expect(page).to have_link 'Help', href: help_path
      expect(page).to have_link 'About', href: about_path
      expect(page).to have_link 'Contact', href: contact_path
    end
  end

  describe 'home' do
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
end
