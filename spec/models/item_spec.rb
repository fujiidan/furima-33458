require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    it '全ての情報を適切に入力すれば商品出品できること' do
      expect(@item).to be_valid
    end

    it '商品画像を1枚つけることが必須であること' do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")
    end

    it '商品名が必須であること' do
      @item.name = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Name can't be blank")
    end

    it '商品の説明が必須であること' do
      @item.text = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Text can't be blank")
    end

    it 'カテゴリーの情報が必須であること' do
      @item.category_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include('Category Select')
    end

    it 'カテゴリーの選択が０では登録できないこと' do
      @item.category_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include('Category Select')
    end

    it '商品の状態についての情報が必須であること' do
      @item.sales_status_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include('Sales status Select')
    end

    it '商品の状態の選択が0では登録できないこと' do
      @item.sales_status_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include('Sales status Select')
    end

    it '配送料の負担についての情報が必須であること' do
      @item.shipping_fee_status_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include('Shipping fee status Select')
    end

    it '配送料の負担の選択が0では登録できないこと' do
      @item.shipping_fee_status_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include('Shipping fee status Select')
    end

    it '発送元の地域についての情報が必須であること' do
      @item.prefecture_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include('Prefecture Select')
    end

    it '発送元の地域の選択が0では登録できないこと' do
      @item.prefecture_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include('Prefecture Select')
    end

    it '発送までの日数についての情報が必須であること' do
      @item.scheduled_delivery_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include('Scheduled delivery Select')
    end

    it '発送までの日数の選択が0では登録できないこと' do
      @item.scheduled_delivery_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include('Scheduled delivery Select')
    end

    it '価格についての情報が必須であること' do
      @item.price = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Price can't be blank")
    end

    it '価格の範囲が、¥299以下だと登録できないこと' do
      @item.price = 299
      @item.valid?
      expect(@item.errors.full_messages).to include('Price Out of setting range')
    end

    it '価格の範囲が、¥10,000,000以上だと登録できないこと' do
      @item.price = 10_000_000
      @item.valid?
      expect(@item.errors.full_messages).to include('Price Out of setting range')
    end

    it '販売価格は半角数字のみ保存可能であること' do
      @item.price = '３００'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price Half-width number')
    end
  end
end
