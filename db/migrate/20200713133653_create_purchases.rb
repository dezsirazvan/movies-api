class CreatePurchases < ActiveRecord::Migration[6.0]
  def change
    create_table :purchases do |t|
      t.integer :user_id
      t.integer :season_id
      t.integer :movie_id

      t.timestamps
    end
  end
end
