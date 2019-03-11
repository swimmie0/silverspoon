# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_03_11_042211) do

  create_table "admins", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "commentable_id"
    t.string "commentable_type"
    t.string "name"
    t.string "title"
    t.text "body"
    t.string "subject"
    t.integer "user_id", null: false
    t.integer "parent_id"
    t.integer "lft"
    t.integer "rgt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "conversations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "sender_id"
    t.integer "recipient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "follows", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "followable_type", null: false
    t.integer "followable_id", null: false
    t.string "follower_type", null: false
    t.integer "follower_id", null: false
    t.boolean "blocked", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followable_id", "followable_type"], name: "fk_followables"
    t.index ["followable_type", "followable_id"], name: "index_follows_on_followable_type_and_followable_id"
    t.index ["follower_id", "follower_type"], name: "fk_follows"
    t.index ["follower_type", "follower_id"], name: "index_follows_on_follower_type_and_follower_id"
  end

  create_table "freeboards", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.string "name"
    t.string "category"
    t.boolean "locked", default: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "completed", default: false
    t.index ["user_id"], name: "index_freeboards_on_user_id"
  end

  create_table "identities", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.string "provider"
    t.string "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_identities_on_user_id"
  end

  create_table "images", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "alt"
    t.string "hint"
    t.string "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "impressions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "impressionable_type"
    t.integer "impressionable_id"
    t.integer "user_id"
    t.string "controller_name"
    t.string "action_name"
    t.string "view_name"
    t.string "request_hash"
    t.string "ip_address"
    t.string "session_hash"
    t.text "message"
    t.text "referrer"
    t.text "params"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index"
    t.index ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index"
    t.index ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index"
    t.index ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index"
    t.index ["impressionable_type", "impressionable_id", "params"], name: "poly_params_request_index", length: { params: 255 }
    t.index ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index"
    t.index ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index"
    t.index ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index", length: { message: 255 }
    t.index ["user_id"], name: "index_impressions_on_user_id"
  end

  create_table "menus", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "menu_name"
    t.integer "a1_maemil"
    t.integer "a2_mil"
    t.integer "a3_daedu"
    t.integer "a4_hodu"
    t.integer "a5_ddangkong"
    t.integer "a6_peach"
    t.integer "a7_tomato"
    t.integer "a8_piggogi"
    t.integer "a9_nanryu"
    t.integer "a10_milk"
    t.integer "a11_ddakgogi"
    t.integer "a12_shoigogi"
    t.integer "a13_saewoo"
    t.integer "a14_godeungeoh"
    t.integer "a15_honghap"
    t.integer "a16_junbok"
    t.integer "a17_gul"
    t.integer "a18_jogaeryu"
    t.integer "a19_gye"
    t.integer "a20_ohjingeoh"
    t.integer "a21_ahwangsan"
    t.bigint "restaurant_id"
    t.string "restaurant_name"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_menus_on_restaurant_id"
  end

  create_table "messages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "body"
    t.bigint "conversation_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "new_alarms", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "content"
    t.bigint "user_id"
    t.string "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_new_alarms_on_user_id"
  end

  create_table "notices", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_notices_on_user_id"
  end

  create_table "profiles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "read_marks", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "readable_type", null: false
    t.integer "readable_id"
    t.string "reader_type", null: false
    t.integer "reader_id"
    t.datetime "timestamp"
    t.index ["readable_type", "readable_id"], name: "index_read_marks_on_readable_type_and_readable_id"
    t.index ["reader_id", "reader_type", "readable_type", "readable_id"], name: "read_marks_reader_readable_index", unique: true
    t.index ["reader_type", "reader_id"], name: "index_read_marks_on_reader_type_and_reader_id"
  end

  create_table "recipes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.text "explain"
    t.text "ingredients"
    t.text "tag"
    t.text "content1"
    t.string "recipeimage1"
    t.text "content2"
    t.string "recipeimage2"
    t.text "content3"
    t.string "recipeimage3"
    t.text "content4"
    t.string "recipeimage4"
    t.text "content5"
    t.string "recipeimage5"
    t.text "content6"
    t.string "recipeimage6"
    t.text "content7"
    t.string "recipeimage7"
    t.text "content8"
    t.string "recipeimage8"
    t.text "content9"
    t.string "recipeimage9"
    t.text "content10"
    t.string "recipeimage10"
    t.bigint "user_id"
    t.string "name"
    t.string "category"
    t.boolean "locked", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "allergyfor"
    t.string "recipeimage0"
    t.index ["user_id"], name: "index_recipes_on_user_id"
  end

  create_table "restaurants", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "restaurant_name"
    t.integer "a1_maemil"
    t.integer "a2_mil"
    t.integer "a3_daedu"
    t.integer "a4_hodu"
    t.integer "a5_ddangkong"
    t.integer "a6_peach"
    t.integer "a7_tomato"
    t.integer "a8_piggogi"
    t.integer "a9_nanryu"
    t.integer "a10_milk"
    t.integer "a11_ddakgogi"
    t.integer "a12_shoigogi"
    t.integer "a13_saewoo"
    t.integer "a14_godeungeoh"
    t.integer "a15_honghap"
    t.integer "a16_junbok"
    t.integer "a17_gul"
    t.integer "a18_jogaeryu"
    t.integer "a19_gye"
    t.integer "a20_ohjingeoh"
    t.integer "a21_ahwangsan"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "userrequests", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "request_type"
    t.string "uid"
    t.text "memo"
    t.string "status"
    t.string "menu_name"
    t.integer "a1_maemil"
    t.integer "a2_mil"
    t.integer "a3_daedu"
    t.integer "a4_hodu"
    t.integer "a5_ddangkong"
    t.integer "a6_peach"
    t.integer "a7_tomato"
    t.integer "a8_piggogi"
    t.integer "a9_nanryu"
    t.integer "a10_milk"
    t.integer "a11_ddakgogi"
    t.integer "a12_shoigogi"
    t.integer "a13_saewoo"
    t.integer "a14_godeungeoh"
    t.integer "a15_honghap"
    t.integer "a16_junbok"
    t.integer "a17_gul"
    t.integer "a18_jogaeryu"
    t.integer "a19_gye"
    t.integer "a20_ohjingeoh"
    t.integer "a21_ahwangsan"
    t.integer "restaurant_id"
    t.string "restaurant_name"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string "IDe"
    t.string "name"
    t.string "allergy"
    t.string "allergy_etc"
    t.string "gender", default: ""
    t.string "ages"
    t.string "profileimg"
    t.boolean "isExpert", default: false
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "votes", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "votable_type"
    t.integer "votable_id"
    t.string "voter_type"
    t.integer "voter_id"
    t.boolean "vote_flag"
    t.string "vote_scope"
    t.integer "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"
  end

  create_table "zizuminfos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "zizum_name"
    t.string "sido"
    t.string "sigungu"
    t.string "sangse_juso"
    t.string "phone_number"
    t.string "image"
    t.bigint "restaurant_id"
    t.string "restaurant_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "explain"
    t.index ["restaurant_id"], name: "index_zizuminfos_on_restaurant_id"
  end

  add_foreign_key "freeboards", "users"
  add_foreign_key "identities", "users"
  add_foreign_key "notices", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "recipes", "users"
end
