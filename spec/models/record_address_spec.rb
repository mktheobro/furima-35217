require 'rails_helper'

RSpec.describe RecordAddress, type: :model do
  describe '商品購入機能' do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.create(:item)
      @record_address = FactoryBot.build(:record_address, user_id: @user.id, item_id: @item.id)
      sleep 0.1
    end

    context '購入できる場合' do
      it '各項目が正しく入力されていれば購入できる' do
        expect(@record_address).to be_valid
      end
      it '建物名がなくても購入できる' do
        @record_address.building = ''
        expect(@record_address).to be_valid
      end
    end

    context '購入できない場合' do
      it '郵便番号がないと購入できない' do
        @record_address.potal_code = ''
        @record_address.valid?
        expect(@record_address.errors.full_messages).to include("Potal code can't be blank")
      end
      it '郵便番号にハイフンがないと購入できない' do
        @record_address.potal_code = '1234567'
        @record_address.valid?
        expect(@record_address.errors.full_messages).to include('Potal code Input correctly')
      end
      it '郵便番号が前３桁後ろ４桁でないと購入できない' do
        @record_address.potal_code = '1234-567'
        @record_address.valid?
        expect(@record_address.errors.full_messages).to include('Potal code Input correctly')
      end
      it '郵便番号に数字とハイフン以外が入力されていると購入できない' do
        @record_address.potal_code = 'あああ'
        @record_address.valid?
        expect(@record_address.errors.full_messages).to include('Potal code Input correctly')
      end
      it '都道府県がないと購入できない' do
        @record_address.prefecture_id = ''
        @record_address.valid?
        expect(@record_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '都道府県を選んでいないと購入できない' do
        @record_address.prefecture_id = '1'
        @record_address.valid?
        expect(@record_address.errors.full_messages).to include('Prefecture Select')
      end
      it '市区町村がないと購入できない' do
        @record_address.city = ''
        @record_address.valid?
        expect(@record_address.errors.full_messages).to include("City can't be blank")
      end
      it '番地がないと購入できない' do
        @record_address.address = ''
        @record_address.valid?
        expect(@record_address.errors.full_messages).to include("Address can't be blank")
      end
      it '電話番号がないと購入できない' do
        @record_address.phone_number = ''
        @record_address.valid?
        expect(@record_address.errors.full_messages).to include('Phone number Input only number')
      end
      it '電話番号が数字でないと購入できない' do
        @record_address.phone_number = 'あああ'
        @record_address.valid?
        expect(@record_address.errors.full_messages).to include('Phone number Input only number')
      end
      it '電話番号が12けた以上だと購入できない' do
        @record_address.phone_number = '111111111111'
        @record_address.valid?
        expect(@record_address.errors.full_messages).to include('Phone number Input only number')
      end
      it 'クレジットカード情報が空だと購入できない' do
        @record_address.token = nil
        @record_address.valid?
        expect(@record_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
