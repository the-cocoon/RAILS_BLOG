class RailsBlogCreatePublications < ActiveRecord::Migration
  def change
    %w[ pages posts ].each do |table_name|
      create_table table_name do |t|
        t.integer :user_id

        # Friendly id
        t.string :slug,        default: ''
        t.string :short_id,    default: ''
        t.string :friendly_id, default: ''

        # MAIN IMAGE | paperclip
        t.string   :main_image_file_name
        t.string   :main_image_content_type
        t.integer  :main_image_file_size, default: 0
        t.datetime :main_image_updated_at

        # Base
        t.string :title, default: ''

        t.text :raw_intro
        t.text :intro

        t.text :raw_content
        t.text :content

        t.string :editor_type, default: :ckeditor

        # View Templates
        t.string :view_layout,   default: ''
        t.string :view_template, default: ''

        # Ext
        t.boolean :optgroup, default: false
        t.integer :view_counter, default: 0
        t.string  :state, default: :draft # draft | published | deleted

        # Denormalization
        t.string :legacy_url
        t.string :inline_tags, default: ''

        # DateTime
        t.datetime :published_at
        t.timestamps
      end
    end
  end
end
