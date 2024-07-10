class Stock < ApplicationRecord
  belongs_to :article

  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :minimum_stock_level, presence: true, numericality: { greater_than_or_equal_to: 0 }


  accepts_nested_attributes_for :article
end
