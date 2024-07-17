require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'lastnameとfirstname、email、passwordとpassword_confirmation、affiliation_idが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'lastnameが空では登録できない' do
        @user.lastname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Lastname を入力してください", "Lastname は全角文字を入力してください")
      end
      it 'lastnameは全角文字以外は登録できない' do
        @user.lastname = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Lastname は全角文字を入力してください")
      end
      it 'firstnameが空では登録できない' do
        @user.firstname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Firstname を入力してください")
      end
      it 'firstnameは全角文字以外は登録できない' do
        @user.firstname = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Firstname は全角文字を入力してください")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email を入力してください")
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email の形式が正しくありません")
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        @user2 = FactoryBot.build(:user)
        @user2.email = @user.email
        @user2.valid?
        expect(@user2.errors.full_messages).to include("Email はすでに存在します")
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password を入力してください")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = 'aaa11'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password は6文字以上で入力してください")
      end
      it 'passwordが129文字以上では登録できない' do
        @user.password = 'a' * 129
        @user.valid?
        expect(@user.errors.full_messages).to include("Password は128文字以下で入力してください")
      end
      it 'passwordが半角英数字以外は登録できない' do
        @user.password = 'ああああああ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password は半角英数字で入力してください")
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password_confirmation = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation パスワード確認が一致しません")
      end
      it 'affiliation_idが空では登録できない' do
        @user.affiliation_id = 1
        @user.valid?
        expect(@user.errors.full_messages).to include("Affiliation を入力してください")
      end
    end
  end
end
