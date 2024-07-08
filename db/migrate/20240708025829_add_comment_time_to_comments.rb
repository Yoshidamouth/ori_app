class AddCommentTimeToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :comment_time, :datetime
  end
end
