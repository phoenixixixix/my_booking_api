class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :country, null: false
      t.string :city, null: false
      t.string :street, null: false
      t.string :phone_number, null: false
      t.belongs_to :property, foreign_key: true

      t.timestamps
    end
  end
end
