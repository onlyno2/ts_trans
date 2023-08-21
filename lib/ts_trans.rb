# frozen_string_literal: true

require_relative 'ts_trans/version'
require_relative 'ts_trans/configuration'
require_relative 'ts_trans/generator'

module TsTrans
  class << self
    def setup(&block)
      configration.assign_attributes(&block)
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def generate
      Generator.new.generate
    end
  end
end
