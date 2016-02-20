# This migration comes from rails_blog_engine (originally 1300)
class RailsBlogCreatePubCategoryRels < ActiveRecord::Migration
  def change
    create_table :pub_category_rels do |t|
      t.references :category, polymorphic: true
      t.references :item, polymorphic: true

      t.string :item_title, default: ''
      t.string :item_state, default: :draft # draft | published | deleted

      t.datetime :item_created_at
      t.datetime :item_updated_at
      t.datetime :item_published_at

      # Nested Set
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.integer :depth, default: 0

      t.timestamps
    end
  end
end
