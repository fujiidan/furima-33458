require 'rails_helper'

RSpec.describe 'Orders', type: :system do
  before do
    @item = FactoryBot.create(:item)
    @user = FactoryBot.create(:user)
    @order = FactoryBot.create(:order)
  end
  describe '商品購入機能' do

    it 'ログアウト状態のユーザーは、URLを直接入力して商品購入ページに遷移しようとすると、商品の販売状況に関わらずログインページに遷移すること' do
      visit item_orders_path(@item)
      expect(current_path).to eq new_user_session_path
    end

    it 'ログイン状態の出品者が、URLを直接入力して自身の出品した商品購入ページに遷移しようとすると、トップページに遷移すること' do
      log_in(@item.user)
      visit item_orders_path(@item)
      expect(current_path).to eq root_path
    end

    it 'ログイン状態のユーザーが、URLを直接入力して売却済み商品の商品購入ページへ遷移しようとすると、トップページに遷移すること' do
      log_in(@user)
      visit item_orders_path(@order.item)
      expect(current_path).to eq root_path
    end
  end
end
