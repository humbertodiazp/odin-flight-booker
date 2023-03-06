class CreateAirports < ActiveRecord::Migration[7.0]
  def change
    create_table :airports do |t|
      t.string :code

      t.timestamps
    end
    add_index :airports, :code, unique: true
  end
end
