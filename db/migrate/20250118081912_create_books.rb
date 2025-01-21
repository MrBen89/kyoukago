class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :genre
      t.string :isbn
      t.string :publisher
      t.string :language
      t.date :publication_date
      t.integer :page_count

      t.timestamps
    end
  end
end
