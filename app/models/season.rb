class Season < ApplicationRecord
  validates :title, presence: true
  validates :plot, presence: true

  has_many :purchases, dependent: :destroy
  has_many :episodes, dependent: :destroy

  scope :ordered_by_episodes_and_creation, -> { order('created_at ASC').order('episodes_count DESC') }
end
