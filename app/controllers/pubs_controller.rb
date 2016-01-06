class PubsController < ApplicationController
  before_action :user_require,   except: %w[ index ]
  before_action :owner_required, except: %w[ index ]
  before_action :admin_require,  except: %w[ index ]

  layout 'rails_blog_layout'

  def index
    @hub  = Hub.published.friendly_first(:main)
    @hubs = Hub.nested_set.roots.published

    sub_sql = HubItemRel
                .published
                .where(hub: @hub)
                .select(%{ DISTINCT ON ("item_id", "item_type") * })
                .to_sql

    @pub_items = HubItemRel
                  .from("(#{ sub_sql }) hub_item_rels")
                  .includes(:item)
                  .max2min([:id])
                  .simple_sort(params)
                  .pagination(params)
  end

  # Restricted area

  def manage
    sub_sql = HubItemRel
                .for_manage
                .select(%{ DISTINCT ON ("item_id", "item_type") * })
                .to_sql

    @pub_items = HubItemRel
                  .from("(#{ sub_sql }) hub_item_rels")
                  .includes(:item)
                  .max2min([:id])
                  .simple_sort(params)
                  .pagination(params)
  end
end