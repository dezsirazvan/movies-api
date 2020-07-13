# frozen_string_literal: true

class Api::V1::BaseController < ActionController::API
  include ApiErrorHandling

  before_action :authorize_client!, :set_current_user

  protected

  def authorize_client!
      doorkeeper_authorize!(:client)
  end

  def set_current_user
    if doorkeeper_token
      @current_user = User.find(doorkeeper_token[:resource_owner_id])
    end
  end

  def render_error_message(message)
    render json: {
      message: 'Validation Failed',
      errors: [message] || object.errors.messages,
      code: 'unprocessable_entity'
    }, status: :unprocessable_entity
  end

  def render_success_message(message)
    render json: {
      message: message
    }, status: :ok
  end
end
