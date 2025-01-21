class ChangeFieldNameForReviews < ActiveRecord::Migration[7.1]
  def change
    rename_column :reservation_reviews, :bookings_id, :booking_id
  end
end
