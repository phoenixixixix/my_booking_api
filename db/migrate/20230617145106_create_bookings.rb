class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.references :user, null: false, foreign_key: true, index: false
      t.references :property, null: false, foreign_key: true, index: false
      t.date :from_date, null: false
      t.date :to_date, null: false

      t.timestamps
    end
  end
end
