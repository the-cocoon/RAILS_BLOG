# include ::RailsBlog::PublicationModel
module RailsBlog
  module PublicationModel
    extend ActiveSupport::Concern

    # class_methods do; end

    included do
      include ::RailsBlog::PubStates
      include ::RailsBlog::PubScopes
      include ::RailsBlog::PubConsistency
      include ::RailsBlog::PubContentProcessing

      include ::SimpleSort::Base
      include ::Pagination::Base
      include ::HasMetaData::Holder
      include ::TheStorages::Storage
      include ::FriendlyIdPack::Base
      include ::AttachedImages::ItemModel
      include ::TheCommentsBase::Commentable

      belongs_to :user

      ########################################
      # Relations
      # Publications categorization
      ########################################
      has_many :pub_category_item_rels,
        as: :item

      has_many :hubs,
        through: :pub_category_item_rels,
        source: :category,
        source_type: :Hub
      ########################################

      before_save :set_published_at

      def owner?(check_user = nil)
        return false unless check_user.is_a?(::User)
        user == check_user
      end

      def set_published_at
        if published_at.blank? && published?
          self.published_at = Time.now
        end
      end
    end
  end
end