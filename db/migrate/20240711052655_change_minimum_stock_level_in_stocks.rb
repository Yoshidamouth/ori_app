class ChangeMinimumStockLevelInStocks < ActiveRecord::Migration[7.0]
  def change
    change_column_null :stocks, :minimum_stock_level, true
  end
end
