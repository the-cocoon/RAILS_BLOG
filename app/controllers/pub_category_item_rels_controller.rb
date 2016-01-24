class PubCategoryItemRelsController < ApplicationController
  include ::TheSortableTreeController::ReversedRebuild

  before_action :user_require,   except: %w[ ]
  before_action :owner_required, except: %w[ ]
  before_action :admin_require,  except: %w[ ]

  before_action :set_category_pub, except: %w[ rebuild ]

  def create
    checked = params[:checked].to_i == 1
    checked ? create_pub_category_item_rels(params) : destroy_pub_category_item_rels(params)
  end

  # Restricted area

  def create_pub_category_item_rels params
    PubCategoryItemRel.create(category: @category, item: @pub)
    @pub.keep_consistency!
    render template: 'pub_category_item_rels/create.success.json.jbuilder'
  end

  def destroy_pub_category_item_rels params
    PubCategoryItemRel.where(category: @category, item: @pub).delete_all
    render template: 'pub_category_item_rels/destroy.success.json.jbuilder'
  end

  def set_category_pub
    @cat_klass = params[:category_type].constantize
    @category = @cat_klass.find params[:category_id]

    @pub_klass = params[:pub_type].constantize
    @pub = @pub_klass.find params[:pub_id]
  end
end