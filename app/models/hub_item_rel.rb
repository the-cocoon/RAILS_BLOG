# HubItemRel.where(hub: Hub.first).nested_set.includes(:item).page(1).per(2)
class HubItemRel < ActiveRecord::Base
  include ::SimpleSort::Base
  include ::Pagination::Base
  include ::TheSortableTree::Scopes

  STATE_FILED_NAME = :item_state
  include ::RailsBlog::PubStates

  paginates_per 24
  acts_as_nested_set scope: :hub_id

  belongs_to :hub
  belongs_to :item, polymorphic: true

  validates :hub, uniqueness: { scope: %w[ item_id item_type ] }

  before_save :define_item_state

  def define_item_state
    self.item_state = item.state
  end
end