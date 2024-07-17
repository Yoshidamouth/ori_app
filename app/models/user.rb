class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :affiliation

  validates :lastname, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龠々]+\z/, message: "は全角文字を入力してください" }
  validates :firstname, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龠々]+\z/, message: "は全角文字を入力してください" }
  validates :affiliation_id, presence: true, numericality: { other_than: 1 ,message: "を入力してください"} 
  validates :password, presence: true, length: { minimum: Devise.password_length.first, maximum: Devise.password_length.last }, format: { with: /\A[a-zA-Z0-9]+\z/, message: "は半角英数字で入力してください" }, if: :password_required?

  belongs_to :affiliation
  has_many :requests
  has_many :comments
end