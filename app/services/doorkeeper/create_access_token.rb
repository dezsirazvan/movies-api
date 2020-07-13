# frozen_string_literal: true

class Doorkeeper::CreateAccessToken < BaseService
  parameters :user_id, :scope

  def call
    doorkeeper_config = Doorkeeper.configuration

    Doorkeeper::AccessToken.create!(
      resource_owner_id: user_id,
      expires_in: doorkeeper_config.access_token_expires_in,
      use_refresh_token: doorkeeper_config.refresh_token_enabled?,
      scopes: scope
    )
  end
end
