class HubItemRelsController < ApplicationController
  include ::TheSortableTreeController::ReversedRebuild

  before_action :user_require,   except: %w[ ]
  before_action :owner_required, except: %w[ ]
  before_action :admin_require,  except: %w[ ]

  before_action :set_pub, except: %w[ rebuild ]

  def create
    checked = params[:checked].to_i == 1
    checked ? create_hub_item_rels(params) : destroy_hub_item_rels(params)
  end

  # Restricted area

  def create_hub_item_rels params
    HubItemRel.create(hub_id: params[:hub_id], item: @pub)
    @pub.keep_consistency!
    render template: 'hub_item_rels/create.success.json.jbuilder'
  end

  def destroy_hub_item_rels params
    HubItemRel.where(hub_id: params[:hub_id], item: @pub).delete_all
    render template: 'hub_item_rels/destroy.success.json.jbuilder'
  end

  def set_pub
    @pub_klass = params[:pub_type].constantize
    @pub = @pub_klass.find params[:pub_id]
  end
end