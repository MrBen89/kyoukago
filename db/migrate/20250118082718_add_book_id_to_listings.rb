class AddBookIdToListings < ActiveRecord::Migration[7.1]
  def change
    add_reference :listings, :books, null: false, foreign_key: true
  end
end
