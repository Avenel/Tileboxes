class RemoveUserIdToBoxes < ActiveRecord::Migration
  def change
    remove_column :boxes, :user_id, :integer
  end
end
