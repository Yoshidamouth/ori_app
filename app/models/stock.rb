class Stock < ApplicationRecord
  belongs_to :article

  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :minimum_stock_level, numericality: { only_integer: true, greater_than_or_equal_to: 0, allow_blank: true }

  accepts_nested_attributes_for :article
end
