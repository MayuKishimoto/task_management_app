ActiveRecord::Schema.define(version: 2023_05_05_002423) do

  enable_extension "plpgsql"

  create_table "tasks", force: :cascade do |t|
    t.string "title", null: false
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "expired_at", default: -> { "now()" }, null: false
    t.string "status", default: "未着手", null: false
  end

end
