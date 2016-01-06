class Hub < ActiveRecord::Base
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

  acts_as_nested_set scope: :user

  belongs_to :user
  has_many :hub_item_rels

  has_many :posts, through: :hub_item_rels, source: :item, source_type: :Post
  has_many :pages, through: :hub_item_rels, source: :item, source_type: :Page
end