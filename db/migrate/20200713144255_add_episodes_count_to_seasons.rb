class AddEpisodesCountToSeasons < ActiveRecord::Migration[6.0]
  def change
    add_column :seasons, :episodes_count, :integer, default: 0
  end
end
