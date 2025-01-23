class ChangeFieldNameForListings < ActiveRecord::Migration[7.1]
  def change
    rename_column :listings, :books_id, :book_id
  end
end
