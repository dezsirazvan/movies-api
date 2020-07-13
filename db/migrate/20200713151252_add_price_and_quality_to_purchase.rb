class AddPriceAndQualityToPurchase < ActiveRecord::Migration[6.0]
  def change
    add_column :purchases, :price, :float, default: 2.99
    add_column :purchases, :quality, :integer, default: 0
  end
end
