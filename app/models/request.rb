class Request < ApplicationRecord
  validates :article_id, :quantity, :status, :user_id, :request_time, presence: true
  validates :quantity, format: { with: /\A\d+\z/, message: "は半角数字で入力してください" },
                       numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 100 }

  has_many :comments
  belongs_to :user
  belongs_to :article
  belongs_to :response_user, class_name: 'User', optional: true

  validate :custom_article_validation

  private

  def custom_article_validation
    if article_id.blank?
      errors.add(:article_id, "を選択してください")
    end
  end
end