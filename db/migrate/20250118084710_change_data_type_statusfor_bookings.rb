class ChangeDataTypeStatusforBookings < ActiveRecord::Migration[7.1]
  def change
    change_column :bookings, :status, 'integer USING CAST(status AS integer)'
  end
end
