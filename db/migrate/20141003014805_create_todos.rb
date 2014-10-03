class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :name
      t.string :description
      t.integer :time
      t.integer :box_id
      t.boolean :done

      t.timestamps
    end
  end
end
