class CreateProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :properties do |t|
      t.string :title, null: false
      t.string :placement_type, null: false

      t.timestamps
    end
  end
end
