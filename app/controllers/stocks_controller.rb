class StocksController < ApplicationController
  def index
    @stocks =  Stock.all
  end

  def new
    @article_stock =  ArticleStock.new
  end

  def create
    @article_stock = ArticleStock.new(stock_params)
    if @article_stock.valid?
      @article_stock.save
      redirect_to stocks_path, notice: '在庫が追加されました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show

  end

  def stock_params
    params.require(:article_stock).permit(:name, :quantity, :minimum_stock_level)
  end

end

