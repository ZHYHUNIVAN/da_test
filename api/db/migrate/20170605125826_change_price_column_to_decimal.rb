class ChangePriceColumnToDecimal < ActiveRecord::Migration[5.1]
  def change
    change_column :artworks, :price, :decimal, :precision => 10, :scale => 2, null: false
  end
end
