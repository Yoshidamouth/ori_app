require 'rails_helper'

RSpec.describe Request, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @request = FactoryBot.build(:request, user: @user)
  end

  describe '依頼要項' do
    context '依頼要項できるとき' do
      it 'article_idとquantity、statusとrequest_timeが存在すれば登録できる' do
        expect(@request).to be_valid
      end
    end

    context '依頼要項できないとき' do
      it 'article_idが空では登録できない' do
        @request.article_id = nil
        @request.valid?
        expect(@request.errors.full_messages).to include("Article を選択してください")
      end

      it 'quantityが空では登録できない' do
        @request.quantity = ''
        @request.valid?
        expect(@request.errors.full_messages).to include("Quantity を入力してください")
      end

      it 'quantityが0では登録できない' do
        @request.quantity = 0
        @request.valid?
        expect(@request.errors.full_messages).to include("Quantity は1以上100以下の半角数字で入力してください")
      end

      it 'quantityが101文字以上では登録できない' do
        @request.quantity = 101
        @request.valid?
        expect(@request.errors.full_messages).to include("Quantity は1以上100以下の半角数字で入力してください")
      end

      it 'quantityは半角数字以外は登録できない' do
        @request.quantity = '１'
        @request.valid?
        expect(@request.errors.full_messages).to include("Quantity は1以上100以下の半角数字で入力してください")
      end

      it 'statusが空では登録できない' do
        @request.status = ''
        @request.valid?
        expect(@request.errors.full_messages).to include("Status を入力してください")
      end

      it 'request_timeが空では登録できない' do
        @request.request_time = ''
        @request.valid?
        expect(@request.errors.full_messages).to include("Request time を入力してください")
      end

      it 'userが関連付けられていない場合は登録できない' do
        @request.user = nil
        @request.valid?
        expect(@request.errors.full_messages).to include("User を入力してください")
      end
    end
  end
end