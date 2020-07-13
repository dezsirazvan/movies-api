# frozen_string_literal: true

class Api::V1::SeasonSerializer < ActiveModel::Serializer
  attributes  :id,
              :title,
              :plot,
              :episodes_count

  has_many :episodes
end
  