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

  describe '商品一覧表示機能' do
    it '商品を出品するとトップページに推移し、商品の画像、名前、価格、配送手数料の情報が表示されていること' do
      sign_in(@item.user)
      create_item(@item)
      expect(page).to have_selector("img[src$='test_image.png']")
      expect(page).to have_content(@item.name)
      expect(page).to have_content(@item.price)
      expect(page).to have_content(@item.shipping_fee_status.name)
    end
  end

  describe '商品詳細ページ' do
    before do
      @item.save
      @user = FactoryBot.create(:user)
    end

    it '商品出品時に登録した情報が見られるようになっていること' do
      visit item_path(@item)
      expect(page).to have_content(@item.name)
      expect(page).to have_content(@item.price)
      expect(page).to have_content(@item.shipping_fee_status.name)
      expect(page).to have_content(@item.text)
      expect(page).to have_content(@item.user.nickname)
      expect(page).to have_content(@item.category.name)
      expect(page).to have_content(@item.sales_status.name)
      expect(page).to have_content(@item.prefecture.name)
      expect(page).to have_content(@item.scheduled_delivery.name)
    end

    it 'ログイン状態の出品者のみ、「編集・削除ボタン」が表示されること' do
      log_in(@item.user)
      visit item_path(@item)
      expect(page).to have_content('編集')
      expect(page).to have_content('削除')
    end

    it 'ログイン状態の出品者でも、売却済みの商品に対しては「編集・削除ボタン」が表示されないこと' do
    end

    it 'ログイン状態の出品者以外のユーザーのみ、「購入画面に進むボタン」が表示されること' do
      log_in(@user)
      visit item_path(@item)
      expect(page).to have_content('購入画面に進む')
    end

    it 'ログアウト状態のユーザーには、「編集・削除・購入画面に進むボタン」が表示されないこと' do
      visit item_path(@item)
      expect(page).to have_no_content('編集')
      expect(page).to have_no_content('削除')
      expect(page).to have_no_content('購入画面に進む')
    end
  end

  describe '商品編集機能' do
    before do
      @item.save
      @user = FactoryBot.create(:user)
    end

    it '必要な情報を適切に入力すると、商品情報（商品画像・商品名・商品の状態など）を変更できること' do
      log_in(@item.user)
      visit edit_item_path(@item)
      fill_in 'item-name', with: 'テストname'
      click_on('変更する')
      expect(current_path).to eq item_path(@item)
      expect(page).to have_content('テストname')
    end

    it 'ログイン状態の出品者だけが商品情報編集ページに遷移できること' do
      log_in(@item.user)
      visit item_path(@item)
      click_on('商品の編集')
      expect(current_path).to eq edit_item_path(@item)
    end

    it 'ログイン状態の出品者以外のユーザーは、URLを直接入力して出品していない商品の商品情報編集ページへ遷移しようとすると、トップページに遷移すること' do
      log_in(@user)
      visit edit_item_path(@item)
      expect(current_path).to eq root_path
    end

    it 'ログアウト状態のユーザーは、URLを直接入力して商品情報編集ページへ遷移しようとすると、ログインページに遷移すること' do
      visit edit_item_path(@item)
      expect(current_path).to eq new_user_session_path
    end

    it '出品者・出品者以外にかかわらず、ログイン状態のユーザーが、URLを直接入力して売却済み商品の商品情報編集ページへ遷移しようとすると、トップページに遷移すること' do
    end

    it 'ログアウト状態のユーザーが、URLを直接入力して売却済み商品の商品情報編集ページへ遷移しようとすると、ログインページに遷移すること' do
    end
  end
end
