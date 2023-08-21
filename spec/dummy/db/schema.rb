# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_08_21_132411) do
  create_table "not_null_type_defs", force: :cascade do |t|
    t.string "string_col", null: false
    t.text "text_col", null: false
    t.integer "integer_col", null: false
    t.integer "enum_col", null: false
    t.bigint "bigint_col", null: false
    t.float "float_col", null: false
    t.decimal "decimal_col", null: false
    t.json "json_col"
    t.binary "binary_col"
    t.boolean "boolean_col"
    t.date "date_col"
    t.datetime "datetime_col"
    t.datetime "col_timestamp", precision: nil
  end

end
