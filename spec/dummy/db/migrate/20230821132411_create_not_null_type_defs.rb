class CreateNotNullTypeDefs < ActiveRecord::Migration[7.0]
  def change # rubocop:disable Metrics/MethodLength
    create_table :not_null_type_defs do |t|
      t.string :string_col, null: false
      t.text :text_col, null: false

      t.integer :integer_col, null: false
      t.integer :enum_col, null: false
      t.bigint :bigint_col, null: false
      t.float :float_col, null: false
      t.decimal :decimal_col, null: false

      t.json :json_col
      # t.jsonb :jsonb_col

      t.binary :binary_col

      t.boolean :boolean_col

      t.date :date_col
      t.datetime :datetime_col

      t.timestamp :col_timestamp
    end
  end
end
