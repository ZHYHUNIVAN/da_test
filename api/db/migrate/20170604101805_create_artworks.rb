class CreateArtworks < ActiveRecord::Migration[5.1]
  def change
    create_table :artworks do |t|
      t.string :state, null: false
      t.string :title, null: false
      t.text :description, null: false
      t.float :price, null: false
      t.references :artist, index: true, foreign_key: true

      t.timestamps
    end
  end
end
