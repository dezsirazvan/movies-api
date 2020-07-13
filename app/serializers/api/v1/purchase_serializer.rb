# frozen_string_literal: true

class Api::V1::PurchaseSerializer < ActiveModel::Serializer
  attributes  :id, :remaining_time_in_hours
 
  belongs_to :movie, optional: true
  belongs_to :season, optional: true

  def remaining_time_in_hours
    time_diff = (object.created_at + 2.days) - DateTime.current 

    (time_diff / 1.hour)
  end
end
    