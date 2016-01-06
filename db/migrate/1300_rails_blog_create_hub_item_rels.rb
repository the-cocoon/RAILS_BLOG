class RailsBlogCreateHubItemRels < ActiveRecord::Migration
  def change
    create_table :hub_item_rels do |t|
      t.integer :hub_id
      t.references :item, polymorphic: true

      # Pub item denormalization
      t.string :item_title, default: ''
      t.string :item_state, default: :draft # draft | published | deleted

      t.datetime :item_created_at
      t.datetime :item_updated_at
      t.datetime :item_published_at
      # ~ Pub item denormalization

      # Nested Set
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.integer :depth, default: 0

      t.timestamps
    end
  end
end
