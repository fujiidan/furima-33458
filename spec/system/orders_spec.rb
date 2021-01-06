require 'rails_helper'

RSpec.describe 'Orders', type: :system do
  before do
    @item = FactoryBot.create(:item)
    @user = FactoryBot.create(:user)
    @order_address = FactoryBot.build(:order_address)
    @order = FactoryBot.create(:order)
  end
  describe '商品購入機能' do
    # it '必要な情報を適切に入力すると、商品の購入ができたのちトップページに戻ること' do
    # log_in(@user)
    # visit item_orders_path(@item)
    # fill_in 'card-number', with: "4242424242424242"
    # fill_in 'card-exp-month', with: "12"
    # fill_in 'card-exp-year', with: "25"
    # fill_in 'card-cvc', with: "123"
    # fill_in 'postal-code', with: @order_address.postal_code
    # find('#prefecture').find("option[value='1']").select_option
    # fill_in 'city', with: @order_address.city
    # fill_in 'addresses', with: @order_address.addresses
    # fill_in 'building', with: @order_address.building
    # fill_in 'phone-number', with: @order_address.phone_number
    # expect(click_on("購入")).to change{Order.count}.by(1)
    # expect(current_path).to eq root_path
    # end

    # it '入力に問題がある状態で購入ボタンが押されたら、購入ページに戻り、クレジットカードの入力履歴のみ残らないこと' do
    # log_in(@user)
    # visit item_orders_path(@item)
    # fill_in 'card-number', with: "4242424242424242"
    # fill_in 'postal-code', with: @order_address.postal_code
    # expect(click_on("購入")).to change{Order.count}.by(0)
    # expect(current_path).to eq item_orders_path(@item)
    # expect(page).to have_no_content("4242424242424242")
    # expect(page).to have_content(@order_address.postal_code)
    # end

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
