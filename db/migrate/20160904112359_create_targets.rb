class CreateTargets < ActiveRecord::Migration[5.0]
  def change
    create_table :targets do |t|
      t.references :position, index: true
      t.string :typename
      t.integer :damage

      t.timestamps
    end
  end
end
