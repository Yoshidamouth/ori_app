class Stock < ApplicationRecord
  validates :article_id, :quantity, :minimum_stock_level, presence: true

  belongs_to :article
end
