class ModifyUsersTable < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :name, :string
    add_column :users, :lastname, :string
    add_column :users, :firstname, :string
  end
end
