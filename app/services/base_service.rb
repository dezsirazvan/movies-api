# frozen_string_literal: true

class BaseService
  def self.parameter(name)
    attr_reader name
    @parameters ||= []
    @parameters << name.to_sym
  end

  def self.parameters(*params)
    params.each do |param|
      parameter(param)
    end
  end

  def self.call(**params)
    new(**params).tap(&:call)
  end

  def self.call_async(**params)
    queue = params[:queue] || 'default'
    ServiceInvocationWorker.set(queue: queue).perform_async(to_s, params.except(:queue))
  end

  def self.call_at(**params)
    queue = params[:queue] || 'default'
    ServiceInvocationWorker.set(queue: queue).perform_at(params[:at], to_s, params.except(:at, :queue))
  end

  def initialize(**params)
    defined_params = self.class.instance_variable_get('@parameters').presence || []

    set_parameters(params, defined_params)

    missing = defined_params - params.keys
    raise ArgumentError, "[#{self.class}] Missing params: #{missing.join(', ')}" unless missing.empty?

    call_init
  end

  def set_parameters(params, defined_params)
    params.each do |param_name, param_value|
      raise ArgumentError, "[#{self.class}] Unexpected param: #{param_name}" unless param_name.in?(defined_params)

      instance_variable_set("@#{param_name}", param_value)
    end
  end

  def call_init
    send(:init) if respond_to?(:init)
  end

  def error(message, http_status = nil)
    result = {
      message: message,
      status: :error
    }

    result[:http_status] = http_status if http_status
    result
  end

  def error_message(error)
    "- #{error.class}: #{error.message}"
  end

  def self.configure(&block)
    block.call(config)
  end

  def self.config
    @config ||= self::Config.new
  end

  def config
    root = Rails.root
    self.class.config
  end

  private_class_method :new
end
