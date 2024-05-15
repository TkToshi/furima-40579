require 'rails_helper'

RSpec.describe OrderResidence, type: :model do
  before do
    item = FactoryBot.create(:item)
    user = FactoryBot.create(:user)
    @order_residence = FactoryBot.build(:order_residence, user_id: user.id, item_id: item.id)
  end

  describe '商品の購入' do
    context '商品が購入できるとき' do
      it 'token、post_code、prefecture_id、municipality、house_number、building_name、phone_numberが存在すれば購入できる' do
        expect(@order_residence).to be_valid
      end
      it '建物名は空でも購入できる' do
        @order_residence.building_name = ''
        expect(@order_residence).to be_valid
      end
    end
    context '商品が購入できないとき' do
      it 'post_codeが空では購入できない' do
        @order_residence.post_code = ''
        @order_residence.valid?
        expect(@order_residence.errors.full_messages).to include("Post code can't be blank")
      end
      it 'post_codeが半角のハイフンを含んだ形式でないと購入できない' do
        @order_residence.post_code = 1113333
        @order_residence.valid?
        expect(@order_residence.errors.full_messages).to include("Post code is invalid. Include hyphen(-)")
      end
      it 'prefecture_idが空では購入できない' do
        @order_residence.prefecture_id = 1
        @order_residence.valid?
        expect(@order_residence.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'municipalityが空では購入できない' do
        @order_residence.municipality = ''
        @order_residence.valid?
        expect(@order_residence.errors.full_messages).to include("Municipality can't be blank")
      end
      it 'house_numberが空では購入できない' do
        @order_residence.house_number = ''
        @order_residence.valid?
        expect(@order_residence.errors.full_messages).to include("House number can't be blank")
      end
      it 'phone_numberが空では購入できない' do
        @order_residence.phone_number = ''
        @order_residence.valid?
        expect(@order_residence.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberは、9桁以下では購入できない' do
        @order_residence.phone_number = 123456789
        @order_residence.valid?
        expect(@order_residence.errors.full_messages).to include("Phone number is invalid. Please enter numbers only")
      end
      it 'phone_numberは、12桁以上では購入できない' do
        @order_residence.phone_number = 123456789101112
        @order_residence.valid?
        expect(@order_residence.errors.full_messages).to include("Phone number is invalid. Please enter numbers only")
      end
      it 'phone_numberは、記号では購入できない' do
        @order_residence.phone_number = '@@@@@@@@@@@'
        @order_residence.valid?
        expect(@order_residence.errors.full_messages).to include("Phone number is invalid. Please enter numbers only")
      end
      it 'phone_numberは、漢字では購入できない' do
        @order_residence.phone_number = '空空空空空空空空空空空'
        @order_residence.valid?
        expect(@order_residence.errors.full_messages).to include("Phone number is invalid. Please enter numbers only")
      end
      it 'phone_numberは、ひらがなでは購入できない' do
        @order_residence.phone_number = 'そらそらそらそらそらそ'
        @order_residence.valid?
        expect(@order_residence.errors.full_messages).to include("Phone number is invalid. Please enter numbers only")
      end
      it 'phone_numberは、カタカナでは購入できない' do
        @order_residence.phone_number = 'ソラソラソラソラソラソ'
        @order_residence.valid?
        expect(@order_residence.errors.full_messages).to include("Phone number is invalid. Please enter numbers only")
      end
      it 'クレジットカード情報が空では購入できない' do
        @order_residence.token = ''
        @order_residence.valid?
        expect(@order_residence.errors.full_messages).to include("Token can't be blank")
      end
      it 'user_idが紐づいていないと購入できない' do
        @order_residence.user_id = ''
        @order_residence.valid?
        expect(@order_residence.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが紐づいていないと購入できない' do
        @order_residence.item_id = ''
        @order_residence.valid?
        expect(@order_residence.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
