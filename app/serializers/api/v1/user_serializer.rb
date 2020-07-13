# frozen_string_literal: true

class Api::V1::UserSerializer < ActiveModel::Serializer
  attributes  :id,
              :email,
              :full_name,
              :token


  def token
    token = object&.access_tokens&.last

    return {} unless token

    {
      access_token: token.token,
      refresh_token: token.refresh_token,
      expires_in: token.expires_in,
      created_at: token.created_at.to_i
    }
  end
end
