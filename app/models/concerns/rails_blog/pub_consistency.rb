# include ::RailsBlog::PubConsistency
module RailsBlog
  module PubConsistency
    # extend ActiveSupport::Concern
    # included do; end
    # class_methods do; end

    def keep_consistency!
      keep_hub_items_consistency!
    end

    def keep_consistency_after_create!
      keep_hub_items_consistency_after_create!
    end

    def keep_consistency_after_update!
      keep_hub_items_consistency_after_update!
    end

    def keep_consistency_after_destroy!
      keep_hub_items_consistency_after_destroy!
    end

    # #############################
    # HubItem consistency
    # #############################

    def keep_hub_items_consistency!
      if hub_item_rels.any?
        keep_consistency_after_update!
      else
        keep_consistency_after_create!
      end
    end

    def keep_hub_items_consistency_after_create!
      hub_item_rels.create(
        item: self,
        item_title: self.title,
        item_state: self.state,
        item_created_at:   self.created_at,
        item_updated_at:   self.updated_at,
        item_published_at: self.published_at
      )
    end

    def keep_hub_items_consistency_after_update!
      hub_item_rels.update_all(
        item_title: self.title,
        item_state: self.state,
        item_created_at:   self.created_at,
        item_updated_at:   self.updated_at,
        item_published_at: self.published_at
      )
    end

    def keep_hub_items_consistency_after_destroy!
      hub_item_rels.delete_all
    end
  end
end
