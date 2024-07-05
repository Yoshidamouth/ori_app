class ArticleStock
  include ActiveModel::Model
  attr_accessor :name, :quantity, :minimum_stock_level

  validates :name, presence: true
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :minimum_stock_level, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def save
    article = Article.create(name: name)
    stock = Stock.create(quantity: quantity, minimum_stock_level: minimum_stock_level, article_id: article.id)
  end
end