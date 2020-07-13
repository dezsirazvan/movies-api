# frozen_string_literal: true

class Api::V1::PurchaseSerializer < ActiveModel::Serializer
  attributes  :id, :remaining_time
 
  belongs_to :movie, optional: true
  belongs_to :season, optional: true

  def remaining_time
    time_diff = Time.now - object.created_at

    Time.at(2.days - time_diff.to_i.abss).utc.strftime "%H:%M:%S"
  end
end
    