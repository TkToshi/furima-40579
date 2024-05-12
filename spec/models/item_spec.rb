require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品の出品' do
    context '商品が出品できるとき' do
      it 'image、item_name、item_description、item_category_id、item_condition_id、
          prefecture_id、shipping_day_id、shipping_fee_id、item_price が存在すれば登録できる' do
        expect(@item).to be_valid
      end
    end
    context '商品が出品できないとき' do
      it '商品画像が空では登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名が空では登録できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end
      it '商品の説明が空では登録できない' do
        @item.item_description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item description can't be blank")
      end
      it 'カテゴリーの情報が空では登録できない' do
        @item.item_category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Item category can't be blank")
      end
      it '商品の状態の情報が空では登録できない' do
        @item.item_condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Item condition can't be blank")
      end
      it '配送料の負担情報が空では登録できない' do
        @item.shipping_fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping fee can't be blank")
      end
      it '発送元の地域情報が空では登録できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '発送までの日数が空では登録できない' do
        @item.shipping_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping day can't be blank")
      end
      it '価格は、空では登録できない' do
        @item.item_price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Item price is not a number')
      end
      it '価格は、記号では登録できない' do
        @item.item_price = '@@@@@'
        @item.valid?
        expect(@item.errors.full_messages).to include('Item price is not a number')
      end
      it '価格は、漢字では登録できない' do
        @item.item_price = '空空空'
        @item.valid?
        expect(@item.errors.full_messages).to include('Item price is not a number')
      end
      it '価格は、ひらがなでは登録できない' do
        @item.item_price = 'そらそらそら'
        @item.valid?
        expect(@item.errors.full_messages).to include('Item price is not a number')
      end
      it '価格は、カタカナでは登録できない' do
        @item.item_price = 'ソラソラソラ'
        @item.valid?
        expect(@item.errors.full_messages).to include('Item price is not a number')
      end
      it '価格は、299以下では登録できない' do
        @item.item_price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Item price must be greater than or equal to 300')
      end
      it '価格は、10,000,000以上では登録できない' do
        @item.item_price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Item price must be less than or equal to 9999999')
      end
      it 'itemは、ユーザーが紐づいていないと登録できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end

    end
  end
end
