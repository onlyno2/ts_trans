# frozen_string_literal: true

module TsTrans
  # Gem configuration
  class Configuration
    DEFAULTS = {
      case: :camel,
      namespace: :schema,
      output: -> { Rails.root.join('app', 'assets', 'javascript', 'schema.d.ts') },
      types: -> { YAML.load_file("#{File.expand_path(__dir__)}/type_map.yml").to_h },
      custom_types: {},
      default_type: :any,
      indent: :tap,
      spaces: 2
    }.freeze

    attr_accessor(*DEFAULTS.keys)

    def initialize(options = nil)
      assign_attributes(DEFAULTS)
      return unless options

      assign_attributes(options)
    end

    def assign_attributes(options = nil, &block)
      raise 'Provide options or a block' if options.nil? && block.nil?

      options.each do |attribute, value|
        value = value.call if value.is_a?(Proc)
        send("#{attribute}=", value)
      end

      self
    end
  end
end
