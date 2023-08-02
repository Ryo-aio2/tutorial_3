require 'rails_helper'
 
RSpec.describe "Sessions", type: :system do
  before do
    driven_by(:rack_test)
  end
 
  describe '#new' do
    context '無効な値の場合' do
      it 'flashメッセージが表示される' do
        visit login_path
 
        fill_in 'Email', with: ''
        fill_in 'Password', with: ''
        click_button 'Log in'

        expect(page).to have_selector 'div.alert.alert-danger'

        visit root_path
        expect(page).to_not have_selector 'div.alert.alert-danger'
      end
    end
  end
end