require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe '新規登録/ユーザー情報' do
    it 'ニックネームが必須' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Nickname can't be blank"
    end
    it 'メールアドレスが必須' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Email can't be blank"
    end
    it 'メールアドレスが一意的' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end
    it 'メールアドレスは@が必須' do
      @user.email = @user.email.gsub(/@/, '')
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end
    it 'パスワードが必須' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Password can't be blank"
    end
    it 'パスワードは6文字以上での入力が必須' do
      @user.password = @user.password.slice(0..4)
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end
    it 'パスワードは半角英数字混合での入力が必須（アルファベットだけでは登録できない）' do
      @user.password = @user.password.gsub(/\d/, 'x')
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include('Password can consist of only half-width characters and must contain at least 1 letter and 1 numeric character')
    end
    it 'パスワードは半角英数字混合での入力が必須（数字だけでは登録できない）' do
      @user.password = @user.password.gsub(/\D/, '9')
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include('Password can consist of only half-width characters and must contain at least 1 letter and 1 numeric character')
    end
    it 'パスワードとパスワード（確認）は、値の一致が必須' do
      @user.password_confirmation = @user.password + 'x'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
  end

  describe '新規登録/本人情報確認' do
    it 'お名前(全角)は名字が必須' do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Last name can't be blank"
    end
    it 'お名前(全角)は名前が必須' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "First name can't be blank"
    end
    it 'お名前(全角)の名字は全角（漢字・ひらがな・カタカナ）での入力が必須' do
      @user.last_name = @user.last_name + 'x'
      @user.valid?
      expect(@user.errors.full_messages).to include 'Last name can consist of only full-width characters'
    end
    it 'お名前(全角)の名前は全角（漢字・ひらがな・カタカナ）での入力が必須' do
      @user.first_name = @user.first_name + 'x'
      @user.valid?
      expect(@user.errors.full_messages).to include 'First name can consist of only full-width characters'
    end
    it 'お名前カナ(全角)は名字が必須' do
      @user.last_name_reading = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Last name reading can't be blank"
    end
    it 'お名前カナ(全角)は名前が必須' do
      @user.first_name_reading = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "First name reading can't be blank"
    end
    it 'お名前カナ(全角)の名字は全角（カタカナ）での入力が必須' do
      @user.last_name_reading = @user.last_name_reading + 'x'
      @user.valid?
      expect(@user.errors.full_messages).to include 'Last name reading can consist of only katakana'
    end
    it 'お名前カナ(全角)の名前は全角（カタカナ）での入力が必須' do
      @user.first_name_reading = @user.first_name_reading + 'x'
      @user.valid?
      expect(@user.errors.full_messages).to include 'First name reading can consist of only katakana'
    end
    it '生年月日が必須' do
      @user.birth_date = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Birth date can't be blank"
    end
  end
end
