class Purchase < ApplicationRecord
  enum quality: { hd: 0, sd: 1 }

  belongs_to :user
  belongs_to :movie, optional: true
  belongs_to :season, optional: true

  scope :ordered, -> { order('created_at ASC') }
end
