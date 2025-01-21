class CreateReservationReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reservation_reviews do |t|
      t.references :bookings, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :score
      t.text :comment

      t.timestamps
    end
  end
end
