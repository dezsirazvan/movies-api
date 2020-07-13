class Movie < ApplicationRecord
  validates :title, presence: true
  validates :plot, presence: true

  has_many :purchases, dependent: :destroy

  after_save    :expire_movie_all_cache
  after_destroy :expire_movie_all_cache

  def expire_movie_all_cache
    Rails.cache.delete('Movie.all')
  end

  def self.all_cached
    Rails.cache.fetch('Movie.all') { all.order(:created_at).to_a}
  end
end
