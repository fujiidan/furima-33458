require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe '新規登録' do
    it '全ての情報を入力すれば新規登録できること' do
      expect(@user).to be_valid
    end

    it 'ニックネームが必須であること' do
      @user.nickname = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it 'メールアドレスが必須であること' do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'メールアドレスが一意性であること' do
      @user.email = 'aaa@aaa'
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end

    it 'メールアドレスは、@を含む必要があること' do
      @user.email = '123456'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end

    it 'パスワードが必須であること' do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'パスワードは、6文字以上での入力が必須であること' do
      @user.password = 'abc12'
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end

    it 'パスワードは、半角英数字混合での入力が必須であること' do
      @user.password = '123456'
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include('Password Include both letters and numbers')
    end

    it 'パスワードは、確認用を含めて2回入力すること' do
      @user.password_confirmation = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it 'パスワードとパスワード（確認用）、値の一致が必須であること' do
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'ユーザー本名は、名字が必須であること' do
      @user.first_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'ユーザー本名は、名前がそれぞれ必須であること' do
      @user.last_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'ユーザー本名は、名字が全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
      @user.first_name = 'abc'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name is invalid. Input full-width characters.')
    end

    it 'ユーザー本名は、名前が全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
      @user.last_name = 'abc'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name is invalid. Input full-width characters.')
    end

    it 'ユーザー本名のフリガナは、名字が必須であること' do
      @user.first_name_kana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank")
    end

    it 'ユーザー本名のフリガナは、名前が必須であること' do
      @user.last_name_kana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana can't be blank")
    end

    it 'ユーザー本名の名字のフリガナは、全角（カタカナ）での入力が必須であること' do
      @user.first_name_kana = 'てすと'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name kana is invalid. Input full-width katakana characters.')
    end

    it 'ユーザー本名の名前のフリガナは、全角（カタカナ）での入力が必須であること' do
      @user.last_name_kana = 'てすと'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name kana is invalid. Input full-width katakana characters.')
    end

    it '生年月日が必須であること' do
      @user.user_birth_date = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("User birth date can't be blank")
    end
  end
end
