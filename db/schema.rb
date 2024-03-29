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

ActiveRecord::Schema.define(version: 2020_10_03_200312) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "bands", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "font"
    t.string "topnav_color"
    t.string "topnav_color_secondary"
    t.string "topnav_opacity"
    t.string "topnav_font_size"
    t.string "topnav_font_color"
    t.string "topnav_font_color_secondary"
    t.boolean "rehearsals_active"
    t.boolean "gigs_active"
    t.boolean "chores_active"
    t.boolean "statistics_active"
    t.boolean "website_active"
    t.boolean "info_active"
    t.string "link_color"
  end

  create_table "chores", force: :cascade do |t|
    t.bigint "band_id"
    t.bigint "coordinator_id"
    t.datetime "date_time"
    t.string "title"
    t.integer "min_number"
    t.integer "max_number"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["band_id"], name: "index_chores_on_band_id"
    t.index ["coordinator_id"], name: "index_chores_on_coordinator_id"
  end

  create_table "comfy_blog_posts", force: :cascade do |t|
    t.integer "site_id", null: false
    t.string "title", null: false
    t.string "slug", null: false
    t.integer "layout_id"
    t.text "content_cache"
    t.integer "year", null: false
    t.integer "month", limit: 2, null: false
    t.boolean "is_published", default: true, null: false
    t.datetime "published_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_comfy_blog_posts_on_created_at"
    t.index ["site_id", "is_published"], name: "index_comfy_blog_posts_on_site_id_and_is_published"
    t.index ["year", "month", "slug"], name: "index_comfy_blog_posts_on_year_and_month_and_slug"
  end

  create_table "comfy_cms_categories", force: :cascade do |t|
    t.integer "site_id", null: false
    t.string "label", null: false
    t.string "categorized_type", null: false
    t.index ["site_id", "categorized_type", "label"], name: "index_cms_categories_on_site_id_and_cat_type_and_label", unique: true
  end

  create_table "comfy_cms_categorizations", force: :cascade do |t|
    t.integer "category_id", null: false
    t.string "categorized_type", null: false
    t.integer "categorized_id", null: false
    t.index ["category_id", "categorized_type", "categorized_id"], name: "index_cms_categorizations_on_cat_id_and_catd_type_and_catd_id", unique: true
  end

  create_table "comfy_cms_files", force: :cascade do |t|
    t.integer "site_id", null: false
    t.string "label", default: "", null: false
    t.text "description"
    t.integer "position", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id", "position"], name: "index_comfy_cms_files_on_site_id_and_position"
  end

  create_table "comfy_cms_fragments", force: :cascade do |t|
    t.string "record_type"
    t.bigint "record_id"
    t.string "identifier", null: false
    t.string "tag", default: "text", null: false
    t.text "content"
    t.boolean "boolean", default: false, null: false
    t.datetime "datetime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["boolean"], name: "index_comfy_cms_fragments_on_boolean"
    t.index ["datetime"], name: "index_comfy_cms_fragments_on_datetime"
    t.index ["identifier"], name: "index_comfy_cms_fragments_on_identifier"
    t.index ["record_type", "record_id"], name: "index_comfy_cms_fragments_on_record_type_and_record_id"
  end

  create_table "comfy_cms_layouts", force: :cascade do |t|
    t.integer "site_id", null: false
    t.integer "parent_id"
    t.string "app_layout"
    t.string "label", null: false
    t.string "identifier", null: false
    t.text "content"
    t.text "css"
    t.text "js"
    t.integer "position", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_id", "position"], name: "index_comfy_cms_layouts_on_parent_id_and_position"
    t.index ["site_id", "identifier"], name: "index_comfy_cms_layouts_on_site_id_and_identifier", unique: true
  end

  create_table "comfy_cms_pages", force: :cascade do |t|
    t.integer "site_id", null: false
    t.integer "layout_id"
    t.integer "parent_id"
    t.integer "target_page_id"
    t.string "label", null: false
    t.string "slug"
    t.string "full_path", null: false
    t.text "content_cache"
    t.integer "position", default: 0, null: false
    t.integer "children_count", default: 0, null: false
    t.boolean "is_published", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["is_published"], name: "index_comfy_cms_pages_on_is_published"
    t.index ["parent_id", "position"], name: "index_comfy_cms_pages_on_parent_id_and_position"
    t.index ["site_id", "full_path"], name: "index_comfy_cms_pages_on_site_id_and_full_path"
  end

  create_table "comfy_cms_revisions", force: :cascade do |t|
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.text "data"
    t.datetime "created_at"
    t.index ["record_type", "record_id", "created_at"], name: "index_cms_revisions_on_rtype_and_rid_and_created_at"
  end

  create_table "comfy_cms_sites", force: :cascade do |t|
    t.string "label", null: false
    t.string "identifier", null: false
    t.string "hostname", null: false
    t.string "path"
    t.string "locale", default: "en", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "band_id"
    t.index ["band_id"], name: "index_comfy_cms_sites_on_band_id"
    t.index ["hostname"], name: "index_comfy_cms_sites_on_hostname"
  end

  create_table "comfy_cms_snippets", force: :cascade do |t|
    t.integer "site_id", null: false
    t.string "label", null: false
    t.string "identifier", null: false
    t.text "content"
    t.integer "position", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id", "identifier"], name: "index_comfy_cms_snippets_on_site_id_and_identifier", unique: true
    t.index ["site_id", "position"], name: "index_comfy_cms_snippets_on_site_id_and_position"
  end

  create_table "comfy_cms_translations", force: :cascade do |t|
    t.string "locale", null: false
    t.integer "page_id", null: false
    t.integer "layout_id"
    t.string "label", null: false
    t.text "content_cache"
    t.boolean "is_published", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["is_published"], name: "index_comfy_cms_translations_on_is_published"
    t.index ["locale"], name: "index_comfy_cms_translations_on_locale"
    t.index ["page_id"], name: "index_comfy_cms_translations_on_page_id"
  end

  create_table "ensemble_instruments", force: :cascade do |t|
    t.bigint "ensemble_id"
    t.bigint "instrument_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "party"
    t.index ["ensemble_id"], name: "index_ensemble_instruments_on_ensemble_id"
    t.index ["instrument_id"], name: "index_ensemble_instruments_on_instrument_id"
  end

  create_table "ensemble_instruments_members", id: false, force: :cascade do |t|
    t.bigint "member_id", null: false
    t.bigint "ensemble_instrument_id", null: false
    t.index ["ensemble_instrument_id", "member_id"], name: "ens_in_mem"
    t.index ["member_id", "ensemble_instrument_id"], name: "mem_en_in"
  end

  create_table "ensembles", force: :cascade do |t|
    t.string "name"
    t.bigint "band_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["band_id"], name: "index_ensembles_on_band_id"
  end

  create_table "ensembles_gigs", id: false, force: :cascade do |t|
    t.bigint "gig_id", null: false
    t.bigint "ensemble_id", null: false
    t.index ["ensemble_id", "gig_id"], name: "index_ensembles_gigs_on_ensemble_id_and_gig_id"
    t.index ["gig_id", "ensemble_id"], name: "index_ensembles_gigs_on_gig_id_and_ensemble_id"
  end

  create_table "ensembles_rehearsals", id: false, force: :cascade do |t|
    t.bigint "rehearsal_id", null: false
    t.bigint "ensemble_id", null: false
  end

  create_table "gigs", force: :cascade do |t|
    t.string "title"
    t.string "where"
    t.datetime "date_time"
    t.string "band_contact"
    t.string "event_contact"
    t.boolean "confirmed"
    t.text "about"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "band_id"
    t.datetime "gather_when"
    t.string "gather_where"
    t.string "dresscode"
    t.string "where_address1"
    t.string "where_address2"
    t.text "member_remarks"
    t.text "site_remarks"
    t.index ["band_id"], name: "index_gigs_on_band_id"
  end

  create_table "gigs_members", id: false, force: :cascade do |t|
    t.bigint "gig_id", null: false
    t.bigint "member_id", null: false
    t.index ["gig_id", "member_id"], name: "index_gigs_members_on_gig_id_and_member_id"
  end

  create_table "groups", force: :cascade do |t|
    t.bigint "band_id"
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["band_id"], name: "index_groups_on_band_id"
  end

  create_table "groups_members", id: false, force: :cascade do |t|
    t.bigint "group_id", null: false
    t.bigint "member_id", null: false
  end

  create_table "instruments", force: :cascade do |t|
    t.string "name"
    t.string "family"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "band_id"
    t.index ["band_id"], name: "index_instruments_on_band_id"
  end

  create_table "member_presences", force: :cascade do |t|
    t.bigint "presentable_id"
    t.bigint "member_id"
    t.boolean "present"
    t.string "remarks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "presentable_type"
    t.boolean "will_be_present"
    t.index ["member_id"], name: "index_member_presences_on_member_id"
    t.index ["presentable_id"], name: "index_member_presences_on_presentable_id"
  end

  create_table "members", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.boolean "admin", default: false
    t.bigint "band_id"
    t.string "sign_in_token"
    t.datetime "sign_in_token_sent_at"
    t.integer "role"
    t.index ["band_id"], name: "index_members_on_band_id"
    t.index ["email"], name: "index_members_on_email", unique: true
    t.index ["reset_password_token"], name: "index_members_on_reset_password_token", unique: true
  end

  create_table "messages", force: :cascade do |t|
    t.text "message"
    t.bigint "member_id"
    t.string "messageable_type"
    t.bigint "messageable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "email_notification"
    t.string "title"
    t.index ["member_id"], name: "index_messages_on_member_id"
    t.index ["messageable_type", "messageable_id"], name: "index_messages_on_messageable_type_and_messageable_id"
  end

  create_table "parts", force: :cascade do |t|
    t.bigint "ensemble_instrument_id"
    t.bigint "song_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ensemble_instrument_id"], name: "index_parts_on_ensemble_instrument_id"
    t.index ["song_id"], name: "index_parts_on_song_id"
  end

  create_table "playable_songs", force: :cascade do |t|
    t.bigint "song_id"
    t.integer "playable_id"
    t.string "playable_type"
    t.string "remark"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["song_id"], name: "index_playable_songs_on_song_id"
  end

  create_table "rehearsals", force: :cascade do |t|
    t.bigint "band_id"
    t.string "description"
    t.datetime "date_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "max_present"
    t.index ["band_id"], name: "index_rehearsals_on_band_id"
  end

  create_table "songs", force: :cascade do |t|
    t.string "title"
    t.string "composer"
    t.string "state"
    t.bigint "ensemble_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "band_id"
    t.index ["band_id"], name: "index_songs_on_band_id"
    t.index ["ensemble_id"], name: "index_songs_on_ensemble_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "chores", "bands"
  add_foreign_key "chores", "members", column: "coordinator_id"
  add_foreign_key "comfy_cms_sites", "bands"
  add_foreign_key "ensemble_instruments", "ensembles"
  add_foreign_key "ensemble_instruments", "instruments"
  add_foreign_key "gigs", "bands"
  add_foreign_key "groups", "bands"
  add_foreign_key "instruments", "bands"
  add_foreign_key "member_presences", "members"
  add_foreign_key "members", "bands"
  add_foreign_key "parts", "ensemble_instruments"
  add_foreign_key "parts", "songs"
  add_foreign_key "playable_songs", "songs"
  add_foreign_key "rehearsals", "bands"
  add_foreign_key "songs", "bands"
end
