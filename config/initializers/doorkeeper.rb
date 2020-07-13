# frozen_string_literal: true

Doorkeeper.configure do
  orm :active_record

  default_scopes :client

  grant_flows %w[password]
  skip_authorization do
    true
  end

  use_refresh_token

  access_token_expires_in 1.hour
end
