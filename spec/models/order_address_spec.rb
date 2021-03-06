require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '商品購入機能' do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.create(:item)
      @order_address = FactoryBot.build(:order_address, user_id: @user.id, item_id: @item.id)
      sleep 0.1
    end
    context '商品の購入ができる場合' do
      it '必要な情報を適切に入力すると、商品の購入ができること' do
        expect(@order_address).to be_valid
      end

      it '建物名が空でも登録できること' do
        @order_address.building = nil
        expect(@order_address).to be_valid
      end
    end

    context '商品の購入ができない場合' do
      it 'user_idが必須であること' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end

      it 'user_idが必須であること' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end

      it 'クレジットカードのトークンが必須であること' do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end

      it '郵便番号が必須であること' do
        @order_address.postal_code = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
      end

      it '郵便番号にはハイフンが必要であること（123-4567となる）' do
        @order_address.postal_code = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end

      it '都道府県の入力が必須であること' do
        @order_address.prefecture_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Prefecture Select')
      end

      it '都道府県の入力が0では登録できないこと' do
        @order_address.prefecture_id = 0
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Prefecture Select')
      end

      it '番地が必須であること' do
        @order_address.city = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end

      it '電話番号が必須であること' do
        @order_address.phone_number = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号にはハイフンは不要で、10桁以上であること（0312345678となる）' do
        @order_address.phone_number = '123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is too short (minimum is 10 characters)')
      end

      it '電話番号にはハイフンは不要で、11桁以下であること（09012345678となる）' do
        @order_address.phone_number = '123456789101112'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is too long (maximum is 11 characters)')
      end

      it '電話番号は数字のみ入力可能であること' do
        @order_address.phone_number = '03-1234-5678'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number input only number')
      end
    end
  end
end
