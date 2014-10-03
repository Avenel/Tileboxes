class AddUserIddefaultToBoxes < ActiveRecord::Migration
  def change
    add_column :boxes, :user_id, :integer, {default: 1}
  end
end
