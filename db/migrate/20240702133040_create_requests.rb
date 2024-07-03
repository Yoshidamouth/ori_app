class CreateRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :requests do |t|
      t.references :article, null: false, foreign_key: true
      t.integer :quantity, null: false
      t.string :status, null: false
      t.references :user, null: false, foreign_key: true
      t.datetime :request_time, null: false
      t.integer :response_user_id, foreign_key: true
      t.datetime :response_time

      t.timestamps
    end
  end
end
