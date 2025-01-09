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

ActiveRecord::Schema[8.0].define(version: 2025_01_08_202901) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "books_condition_enum", ["new", "used", "damaged"]
  create_enum "books_exchangestate_enum", ["available", "requested", "in exchange", "exchanged"]
  create_enum "exchanges_state_enum", ["preparation", "approved", "declined", "completed"]
  create_enum "ratings_targettype_enum", ["exchange", "book"]
  create_enum "status", ["preparation", "sent", "shipping", "delivery"]

  create_table "books", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.string "title", null: false
    t.string "author", null: false
    t.string "genre", null: false
    t.string "language", null: false
    t.enum "condition", default: "new", null: false, enum_type: "books_condition_enum"
    t.string "country", null: false
    t.string "city", null: false
    t.integer "user_id", null: false
    t.enum "exchangeState", default: "available", null: false, enum_type: "books_exchangestate_enum"
    t.integer "exchangesId"
  end

  create_table "complains", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.integer "rating_id"

    t.unique_constraint ["rating_id"], name: "REL_fa559aaf291d3dbf0958ad570d"
  end

  create_table "deliveries", force: :cascade do |t|
    t.string "state", default: "preparation", null: false
    t.integer "book_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dialogs", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
  end

  create_table "dialogs_users_users", primary_key: ["dialogsId", "usersId"], force: :cascade do |t|
    t.integer "dialogsId", null: false
    t.integer "usersId", null: false
    t.index ["dialogsId"], name: "IDX_45925e1556189ecff0f6188f8a"
    t.index ["usersId"], name: "IDX_2a07e45af0b23f552706e28a06"
  end

  create_table "exchanges", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.enum "state", default: "preparation", null: false, enum_type: "exchanges_state_enum"
    t.integer "from_id"
    t.integer "to_id"
    t.integer "book_id"
    t.date "acceptedDate"
    t.date "declinedDate"
    t.date "completedDate"
    t.integer "dialog_id"
    t.index ["from_id", "to_id", "book_id"], name: "idx_from_to_book"
  end

  create_table "messages", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.string "text", null: false
    t.integer "dialog_id"
    t.integer "author_id"
  end

  create_table "notifications", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.string "text", null: false
  end

  create_table "notifications_users_users", primary_key: ["notificationsId", "usersId"], force: :cascade do |t|
    t.integer "notificationsId", null: false
    t.integer "usersId", null: false
    t.index ["notificationsId"], name: "IDX_9a993900ff133379818b377be9"
    t.index ["usersId"], name: "IDX_43985406f387ccdd9ab84bee24"
  end

  create_table "ratings", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.string "text", null: false
    t.integer "rate", null: false
    t.enum "targetType", default: "exchange", null: false, enum_type: "ratings_targettype_enum"
    t.integer "targetId", null: false
    t.integer "owner_id"
    t.integer "complain_id"

    t.unique_constraint ["complain_id"], name: "UQ_4fa2db69f78a434c850b8cf7d40"
  end

  create_table "subscriptions", id: :serial, force: :cascade do |t|
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.integer "subscriber_id"
    t.integer "subscribed_id"
  end

  create_table "user", id: :serial, force: :cascade do |t|
    t.string "email", limit: 320, null: false
    t.string "username", limit: 15, null: false
    t.string "password", limit: 20, null: false
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.index ["email"], name: "IDX_e12875dfb3b1d92d7d7c5377e2", unique: true
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", limit: 320, null: false
    t.string "username", limit: 15, null: false
    t.datetime "createdAt", precision: nil, default: -> { "now()" }, null: false
    t.datetime "updatedAt", precision: nil, default: -> { "now()" }, null: false
    t.string "password", null: false
    t.boolean "isConfirmed", default: false, null: false
    t.string "confirmationToken"
    t.string "resetPasswordToken"
    t.string "avatar"
    t.string "socketId"
    t.string "messagesSocketId"
    t.boolean "notifyByEmail", default: false, null: false
    t.index ["email"], name: "IDX_97672ac88f789774dd47f7c8be", unique: true
  end

  create_table "users_notifications_notifications", primary_key: ["usersId", "notificationsId"], force: :cascade do |t|
    t.integer "usersId", null: false
    t.integer "notificationsId", null: false
    t.index ["notificationsId"], name: "IDX_3d3537db4141c3be60f87160d0"
    t.index ["usersId"], name: "IDX_3f1d0abc296488dd2169ea3ad9"
  end

  add_foreign_key "books", "exchanges", column: "exchangesId", name: "FK_1524f3afc727896d176644b9ef4"
  add_foreign_key "books", "users", name: "FK_d2211ba79c9312cdcda4d7d5860"
  add_foreign_key "complains", "ratings", name: "FK_fa559aaf291d3dbf0958ad570dc"
  add_foreign_key "dialogs_users_users", "dialogs", column: "dialogsId", name: "FK_45925e1556189ecff0f6188f8aa", on_update: :cascade, on_delete: :cascade
  add_foreign_key "dialogs_users_users", "users", column: "usersId", name: "FK_2a07e45af0b23f552706e28a065"
  add_foreign_key "exchanges", "books", name: "FK_efa452dd051248581b8aead210e"
  add_foreign_key "exchanges", "dialogs", name: "FK_40406f4d132846d5a4c0db03589"
  add_foreign_key "exchanges", "users", column: "from_id", name: "FK_c11d276b14c4aebc02bd1577ccf"
  add_foreign_key "exchanges", "users", column: "to_id", name: "FK_d11915ca7fe22a4fe1328501dc3"
  add_foreign_key "messages", "dialogs", name: "FK_4f75ed695862f3b3e9fbd5930e6"
  add_foreign_key "messages", "users", column: "author_id", name: "FK_05535bc695e9f7ee104616459d3"
  add_foreign_key "notifications_users_users", "notifications", column: "notificationsId", name: "FK_9a993900ff133379818b377be96", on_update: :cascade, on_delete: :cascade
  add_foreign_key "notifications_users_users", "users", column: "usersId", name: "FK_43985406f387ccdd9ab84bee24f"
  add_foreign_key "ratings", "complains", name: "FK_4fa2db69f78a434c850b8cf7d40"
  add_foreign_key "ratings", "users", column: "owner_id", name: "FK_a46399f87e1f3296d9c9e4a7c5c"
  add_foreign_key "subscriptions", "users", column: "subscribed_id", name: "FK_aae996430ecc29e2ddc4efe9681"
  add_foreign_key "subscriptions", "users", column: "subscriber_id", name: "FK_f56b7683178d56b3907fea72489"
  add_foreign_key "users_notifications_notifications", "notifications", column: "notificationsId", name: "FK_3d3537db4141c3be60f87160d07"
  add_foreign_key "users_notifications_notifications", "users", column: "usersId", name: "FK_3f1d0abc296488dd2169ea3ad9d", on_update: :cascade, on_delete: :cascade
end
