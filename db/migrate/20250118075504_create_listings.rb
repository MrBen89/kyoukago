class CreateListings < ActiveRecord::Migration[7.1]
  def change
    create_table :listings do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.integer :price
      t.string :condition
      t.text :comment

      t.timestamps
    end
  end
end
