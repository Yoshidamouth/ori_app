class Article < ApplicationRecord
  has_many :requests
  has_one :stock
end
