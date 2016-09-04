class CreateAttacks < ActiveRecord::Migration[5.0]
  def change
    create_table :attacks do |t|
    	
      t.timestamps
    end
  end
end
