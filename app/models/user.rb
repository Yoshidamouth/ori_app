class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :affiliation

  validates :lastname, presence: true
  validates :firstname, presence: true
  validates :affiliation_id, presence: true, numericality: { other_than: 1 ,message: "can't be blank"} 

  # belongs_to :affiliation
  has_many :requests
  # has_many :comments
end