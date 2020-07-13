class Episode < ApplicationRecord
  validates :title, presence: true
  validates :plot, presence: true

  belongs_to :season, counter_cache: true
end
