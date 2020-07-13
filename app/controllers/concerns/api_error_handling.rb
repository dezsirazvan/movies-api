# frozen_string_literal: true

module ApiErrorHandling
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |exception|
      render json: {
        message: "#{exception.model} with id=#{exception.id} not found",
        code: 'not_found'
      }, status: :not_found
    end

    rescue_from ActiveRecord::RecordInvalid do |exception|
      render json: {
        message: 'Validation Failed',
        errors: exception.record.errors.full_messages,
        code: 'unprocessable_entity'
      }, status: :unprocessable_entity
    end

    rescue_from ActionController::ParameterMissing do |exception|
      render json: {
        message: "Parameter missing: #{exception.param}",
        code: 'param_missing'
      }, status: :unprocessable_entity
    end

    rescue_from ArgumentError do |error|
      render json: {
        message: "Argument error: #{error}",
        code: 'argument_error'
      }, status: :unprocessable_entity
    end

    rescue_from CustomError do |error|
      render json: {
        message: error.to_s,
        code: 'unprocessable_entity'
      }, status: :unprocessable_entity
    end

    rescue_from NotAuthorized do |error|
      render json: {
        message: error.message || 'Not authorized',
        code: 'unauthorized'
      }, status: :unauthorized
    end
  end
end
