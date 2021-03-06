# include ::RailsBlog::CategoryModel
module RailsBlog
  module CategoryModel
    extend ActiveSupport::Concern

    included do
      include ::RailsBlog::PubStates
      include ::RailsBlog::PubScopes
      include ::RailsBlog::PubContentProcessing

      include ::SimpleSort::Base
      include ::Pagination::Base
      include ::HasMetaData::Holder
      include ::TheStorages::Storage
      include ::FriendlyIdPack::Base
      include ::TheSortableTree::Scopes
      include ::AttachedImages::ItemModel
      include ::Notifications::LocalizedErrors

      acts_as_nested_set scope: :user

      belongs_to :user

      has_many :pub_category_rels,
        as: :category

      has_many :posts,
        through: :pub_category_rels,
        source: :item,
        source_type: :Post

      has_many :pages,
        through: :pub_category_rels,
        source: :item,
        source_type: :Page

      def owner?(check_user = nil)
        return false unless check_user.is_a?(::User)
        user == check_user
      end

    end
  end
end