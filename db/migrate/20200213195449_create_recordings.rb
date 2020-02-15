class CreateRecordings < ActiveRecord::Migration[6.0]
  def change
    create_table :recordings do |t|
      t.string :product
      t.string :last
      t.string :bid
      t.string :ask

      t.timestamps
    end
    add_index :recordings, :product
  end
end
