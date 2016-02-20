# HubItemRel.where(hub: Hub.first).nested_set.includes(:item).page(1).per(2)

# BlogCategoryRel

# Category - Item

# Hub - post
# Hub - recipe
# Person - post
# Person - recipe
# BlogTag - post
# BlogTag - recipe

# belongs_to :category, polymorphic: true
# belongs_to :item,     polymorphic: true

class PubCategoryRel < ActiveRecord::Base
  include ::SimpleSort::Base
  include ::Pagination::Base
  include ::TheSortableTree::Scopes

  STATE_FILED_NAME = :item_state
  include ::RailsBlog::PubStates

  paginates_per 24
  acts_as_nested_set scope: %w[ category_type category_id ]

  belongs_to :category, polymorphic: true
  belongs_to :item,     polymorphic: true

  validates :category_id, uniqueness: { scope: %w[ category_type item_id item_type ] }

  before_save :define_item_state

  def define_item_state
    self.item_state = item.state
  end
end