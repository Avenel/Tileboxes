class AddUserIddefaultToTodos < ActiveRecord::Migration
  def change
    add_column :todos, :user_id, :integer, {default: 1}
  end
end
