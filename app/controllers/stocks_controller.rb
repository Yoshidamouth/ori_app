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

  def edit
    @stock = Stock.includes(:article).find(params[:id])
  end

  def update
    @stock = Stock.includes(:article).find(params[:id])
  
    if @stock.update(stock_params)
      if @stock.previous_changes.empty?
        redirect_to stocks_path
      else
        redirect_to stocks_path, notice: '在庫が更新されました。'
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def stock_params
    params.require(:stock).permit(:quantity, :minimum_stock_level, article_attributes: [:name, :id])
  end

end

