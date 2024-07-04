class CreateStocks < ActiveRecord::Migration[7.0]
  def change
    create_table :stocks do |t|
      t.references :article, null: false, foreign_key: true
      t.integer :quantity, null: false
      t.integer :minimum_stock_level, null: false


      t.timestamps
    end
  end
end
