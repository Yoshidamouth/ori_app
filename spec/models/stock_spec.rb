require 'rails_helper'

RSpec.describe Request, type: :model do
  before do
    @stock = FactoryBot.build(:stock)
  end

  describe '依頼要項' do
    context '依頼要項できるとき' do
      it 'nameとquantityが存在すれば登録できる' do
        expect(@stock).to be_valid
      end
    end

    context '依頼要項できないとき' do
      it 'nameが空では登録できない' do
        @stock.article.name = ''
        @stock.valid?
        expect(@stock.errors.full_messages).to include("Article name を入力してください")
      end
      it 'quantityが空では登録できない' do
        @stock.quantity = ''
        @stock.valid?
        expect(@stock.errors.full_messages).to include("Quantity を入力してください")
      end
      it 'quantityは半角数字以外は登録できない' do
        @stock.quantity = '１'
        @stock.valid?
        expect(@stock.errors.full_messages).to include("Quantity は半角数字で入力してください")
      end
      it 'minimum_stock_levelは半角数字以外は登録できない' do
        @stock.minimum_stock_level = '１'
        @stock.valid?
        expect(@stock.errors.full_messages).to include("Minimum stock level は半角数字で入力してください")
      end
      it 'minimum_stock_levelが0では登録できない' do
        @stock.minimum_stock_level = 0
        @stock.valid?
        expect(@stock.errors.full_messages).to include("Minimum stock level は1以上の半角数字で入力してください")
      end
    end
  end
end
