class Comment < ApplicationRecord
  validates :content, presence: true, length: { maximum: 200 }
  validates :user_id, :request_id, presence: true

  belongs_to :user
  belongs_to :request
end
