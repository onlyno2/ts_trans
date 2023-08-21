# frozen_string_literal: true

module TsTrans
  # Generator
  class Generator
    def initialize
      Rails.application.eager_load!
      @models = ApplicationRecord.subclasses
      @types = TsTrans.configuration.types.merge(TsTrans.configuration.custom_types || {})
    end

    def generate
      ts = generate_typescript
      save_file(ts)
    end

    private

    def generate_typescript
      type_template = ''

      @models.each do |model|
        type_template = generate_model(model)
      end

      type_template = <<~TYPE_TEMPLATE
        declare namespace #{TsTrans.configuration.namespace} {
        #{indent_wrapper(type_template)}
        }
      TYPE_TEMPLATE
    end

    def generate_model(model)
      columns = map_column_types(model)

      <<~TYPESCRIPT
        interface #{model.model_name.name} {
        #{columns.map do |column|
            "#{indent_as_str}#{output_column_name(column_name(column[:name]))}: #{column[:ts_type]};"
          end.join("\n")
        }
        }
      TYPESCRIPT
    end

    def defined_type(column, model)
      type = @types[column.type.to_s] || TsTrans.configuration.default_type

      enum = model.defined_enums[column.name]
      type = enum.keys.map { |k| "'#{k}'" }.join(' | ') if enum

      type
    end

    def output_column_name(name)
      case TsTrans.configuration.case.to_sym
      when :camel
        name.camelize(:lower)
      when :pascal
        name.camelize
      else
        name
      end
    end

    def column_name(name, nullable: false)
      optional = '?' if nullable
      "#{name}#{optional}"
    end

    def output_column_type(type, nullable: false)
      optional = ' | null' if nullable
      "#{type}#{optional}"
    end

    def map_column_types(model)
      model.columns.map do |column|
        type = defined_type(column, model)

        {
          name: column_name(column.name, nullable: column.null),
          ts_type: output_column_type(type, nullable: column.null)
        }
      end
    end

    def save_file(content)
      path = TsTrans.configuration.output
      FileUtils.mkdir_p(path.dirname)

      return if File.exist?(path) && File.read(path) == content

      File.open(path, 'w') do |f|
        f.write(content)
      end
    end

    def indent_as_str
      case TsTrans.configuration.indent.to_sym
      when :space || :spaces
        ''.rjust(TsTrans.configuration.spaces, ' ')
      else
        "\t"
      end
    end

    def indent_wrapper(str)
      case TsTrans.configuration.indent.to_sym
      when :space || :spaces
        str.indent(TsTrans.configuration.spaces)
      else
        str.indent(1, "\t")
      end
    end
  end
end
