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

  ########################################
  # Relations
  # Publications categorization
  ########################################
  has_many :pub_category_item_rels,
    as: :category

  has_many :posts,
    through: :pub_category_item_rels,
    source: :item,
    source_type: :Post

  has_many :pages,
    through: :pub_category_item_rels,
    source: :item,
    source_type: :Page
  ########################################
end