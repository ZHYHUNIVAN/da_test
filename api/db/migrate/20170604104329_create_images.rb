class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.references :artwork, index: true, foreign_key: true
      t.string :file
      t.string :dimension

      t.timestamps
    end
  end
end
