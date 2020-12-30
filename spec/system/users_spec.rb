require 'rails_helper'

RSpec.describe 'Users', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'トップページ' do
    it 'ログアウト状態では、ヘッダーに新規登録/ログインボタンが表示されること' do
      visit root_path
      expect(page).to have_content('新規登録')
      expect(page).to have_content('ログイン')
    end

    it 'ログイン状態では、ヘッダーにユーザーのニックネーム/ログアウトボタンが表示されること' do
      sign_in(@user)
      expect(page).to have_content(@user.nickname)
      expect(page).to have_content(@user.nickname)
    end

    it 'ヘッダーの新規登録/ログインボタンをクリックすることで、各ページに遷移できること' do
      visit root_path
      click_on('新規登録')
      expect(current_path).to eq new_user_registration_path
      visit root_path
      click_on('ログイン')
      expect(current_path).to eq new_user_session_path
    end

    it 'ヘッダーのログアウトボタンをクリックすることで、ログアウトができること' do
      sign_in(@user)
      click_on('ログアウト')
      expect(page).to have_content('ログイン')
    end
  end
end
