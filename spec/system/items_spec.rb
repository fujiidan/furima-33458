require 'rails_helper'

RSpec.describe 'Items', type: :system do
  before do
    @item = FactoryBot.build(:item)
  end

  describe 'ログインの有無での商品出品ページへの制限' do
    it 'ログイン状態のユーザーだけが、商品出品ページへ遷移できること' do
      sign_in(@item.user)
      click_on('出品する')
      expect(current_path).to eq new_item_path
    end

    it 'ログアウト状態のユーザーは、商品出品ページへ遷移しようとすると、ログインページへ遷移すること' do
      visit root_path
      click_on('出品する')
      expect(current_path).to eq new_user_session_path
    end
  end

  describe '商品出品機能' do
    it '必要な情報を適切に入力すると、商品の出品ができること' do
      sign_in(@item.user)
      create_item(@item)
    end

    it '入力に問題がある状態で出品ボタンが押されたら、出品ページに戻り記入内容が保持されていること' do
      sign_in(@item.user)
      click_on('出品する')
      expect(current_path).to eq new_item_path
      fill_in 'item-name', with: @item.name
      expect { click_on('出品する') }.to change { Item.count }.by(0)
      expect(current_path).to eq items_path
      expect(page).to have_content(@item.name)
    end
  end
end
