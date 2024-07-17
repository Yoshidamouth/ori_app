class Request < ApplicationRecord
  validates :article_id, presence: { message: "を選択してください" }
  validates :quantity,
  presence: { message: "を入力してください" },
  numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 100,
    message: "は1以上100以下の半角数字で入力してください",
    allow_blank: true
  },
  format: { with: /\A[0-9]+\z/, message: "は半角数字で入力してください" }

  validates :status, :user_id, :request_time, presence: true

  has_many :comments, dependent: :destroy
  belongs_to :user
  belongs_to :article, optional: true
  belongs_to :response_user, class_name: 'User', optional: true
end