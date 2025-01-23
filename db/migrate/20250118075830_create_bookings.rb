class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    unless table_exists?(:bookings)
      create_table :bookings do |t|
        t.references :listing, null: false, foreign_key: true
        t.references :user, null: false, foreign_key: true
        t.string :status
        t.integer :total

        t.timestamps
      end
    end
  end
end
