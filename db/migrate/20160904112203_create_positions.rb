class CreatePositions < ActiveRecord::Migration[5.0]
  def change
    create_table :positions do |t|
      t.integer :x
      t.integer :y

      t.timestamps
    end
  end
end
