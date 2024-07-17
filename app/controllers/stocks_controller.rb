class StocksController < ApplicationController
  before_action :authenticate_user!
  before_action :redirect_if_not_branch_user

  def index
    @stocks =  Stock.all
  end

  def new
    @article_stock =  ArticleStock.new
  end

  def create
    @article_stock = ArticleStock.new(create_params)
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
  
    if @stock.update(update_params)
      if @stock.previous_changes.empty?
        redirect_to stocks_path
      else
        redirect_to stocks_path, notice: '在庫が更新されました。'
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @stock = Stock.find(params[:id])
    @stock.destroy
    redirect_to stocks_path, notice: '在庫が削除されました。'
  end

  private

  def create_params
    params.require(:article_stock).permit(:name, :quantity, :minimum_stock_level, article_attributes: [:id])
  end
  
  def update_params
    params.require(:stock).permit(:quantity, :minimum_stock_level, article_attributes: [:name, :id])
  end

  def redirect_if_not_branch_user
    if current_user.affiliation_id != 2
      redirect_to '/'
    end
  end  
end

