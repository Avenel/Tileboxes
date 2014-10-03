class RemoveUserIdToTodos < ActiveRecord::Migration
  def change
    remove_column :todos, :user_id, :integer
  end
end
