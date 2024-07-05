class StocksController < ApplicationController
  def index
    @stocks =  Stock.all
  end

  def new
    @stock =  Stock.new
  end

  def create
    @stock = Stock.new(stock_params)
    if @stock.save
      new_stock_path
    else
      render "stocks/new", status: :unprocessable_entity
    end
  end

  def show

  end

  def stock_params
    params.require(:stock).permit(:article_id, :quantity, :minimum_stock_level)
  end

end

