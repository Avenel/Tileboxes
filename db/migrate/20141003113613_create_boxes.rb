class CreateBoxes < ActiveRecord::Migration
  def change
    create_table :boxes do |t|
      t.string :name
      t.string :description
      t.boolean :done
      t.string :color
      t.datetime :start_date
      t.integer :pos_x
      t.integer :pos_y

      t.timestamps
    end
  end
end
