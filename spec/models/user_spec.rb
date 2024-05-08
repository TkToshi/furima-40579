require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nickname、email、password、password_confirmation、last_name、first_name、read_last_name、
          read_first_name、birthdayが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        user = FactoryBot.build(:user)
        user.nickname = ''
        user.valid?
        expect(user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        user = FactoryBot.build(:user)
        user.email = ''
        user.valid?
        expect(user.errors.full_messages).to include("Email can't be blank")
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordが空では登録できない' do
        user = FactoryBot.build(:user)
        user.password = ''
        user.valid?
        expect(user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '77777'
        @user.password_confirmation = '77777'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'passwordは、129文字以上では登録できない' do
        @user.password = Faker::Internet.password(min_length: 129, max_length: 150)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too long (maximum is 128 characters)')
      end
      it 'passwordは、半角英数字混合しないと登録できない' do
        word = %w[7777777 aaaaaaa]
        word.each do |user|
          @user.password = user
          @user.valid?
          expect(@user.errors.full_messages).to include('Password  is invalid. Include both letters and numbers')
        end
      end
      it 'お名前(全角)は、名字が空では登録できない' do
        user = FactoryBot.build(:user)
        user.last_name = ''
        user.valid?
        expect(user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'お名前(全角)は、名字が記号、英小文字、英大文字、では登録できない' do
        word = ['@@@@@@', 'aaaaaaa', 'AAAAAA']
        word.each do |user|
          @user.last_name = user
          @user.valid?
          expect(@user.errors.full_messages).to include('Last name  is invalid. Input full-width characters')
        end
      end
      it 'お名前(全角)は、名前が空では登録できない' do
        user = FactoryBot.build(:user)
        user.first_name = ''
        user.valid?
        expect(user.errors.full_messages).to include("First name can't be blank")
      end
      it 'お名前(全角)は、名前が記号、英小文字、英大文字、では登録できない' do
        word = ['@@@@@@', 'aaaaaaa', 'AAAAAA']
        word.each do |user|
          @user.first_name = user
          @user.valid?
          expect(@user.errors.full_messages).to include('First name  is invalid. Input full-width characters')
        end
      end
      it 'お名前カナ(全角)は、名字が空では登録できない' do
        user = FactoryBot.build(:user)
        user.read_last_name = ''
        user.valid?
        expect(user.errors.full_messages).to include("Read last name can't be blank")
      end
      it 'お名前カナ(全角)は、名字が記号、英小文字、英大文字、漢字、ひらがなでは登録できない' do
        word = ['@@@@@@', 'aaaaaaa', 'AAAAAA', '空空空空空空', 'そらそらそら']
        word.each do |user|
          @user.read_last_name = user
          @user.valid?
          expect(@user.errors.full_messages).to include('Read last name  is invalid. Input full-width katakana characters')
        end
      end
      it 'お名前カナ(全角)は、名前が空では登録できない' do
        user = FactoryBot.build(:user)
        user.read_first_name = ''
        user.valid?
        expect(user.errors.full_messages).to include("Read first name can't be blank")
      end
      it 'お名前カナ(全角)は、名前が記号、英小文字、英大文字、漢字、ひらがなでは登録できない' do
        word = ['@@@@@@', 'aaaaaaa', 'AAAAAA', '空空空空空空', 'そらそらそら']
        word.each do |user|
          @user.read_first_name = user
          @user.valid?
          expect(@user.errors.full_messages).to include('Read first name  is invalid. Input full-width katakana characters')
        end
      end
      it '生年月日は、空では登録できない' do
        user = FactoryBot.build(:user)
        user.birthday = ''
        user.valid?
        expect(user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
