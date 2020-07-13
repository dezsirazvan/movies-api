class Purchase < ApplicationRecord
  enum quality: { hd: 0, sd: 1 }

  belongs_to :user
  belongs_to :movie, optional: true
  belongs_to :season, optional: true

  scope :ordered, -> { order('created_at ASC') }
  scope :in_library, -> { where('created_at >= ?', DateTime.current - 2.days) }
  scope :not_in_library, -> { where('created_at < ?', DateTime.current - 2.days) }
end
