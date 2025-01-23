class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    unless table_exists?(:books)
      create_table :books do |t|
        t.string :title
        t.string :author
        t.text :overview
        t.string :poster_url
        t.decimal :rating

        t.timestamps
      end
    end
  end
end
