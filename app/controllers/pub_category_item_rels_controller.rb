class PubCategoryItemRelsController < ApplicationController
  include ::TheSortableTreeController::ReversedRebuild

  layout 'rails_blog_layout'

  before_action :user_require,   except: %w[ ]
  before_action :owner_required, except: %w[ ]
  before_action :admin_require,  except: %w[ ]

  before_action :set_category, except: %w[ rebuild ]
  before_action :set_pub,      except: %w[ rebuild ordering ]

  def create
    checked = params[:checked].to_i == 1
    checked ? create_pub_category_item_rels(params) : destroy_pub_category_item_rels(params)
  end

  # Restricted area

  def ordering
    @category_items = @category.pub_category_item_rels.reversed_nested_set
  end

  def create_pub_category_item_rels params
    PubCategoryItemRel.create(category: @category, item: @pub)
    @pub.keep_consistency!
    render template: 'pub_category_item_rels/json/create.success.json.jbuilder'
  end

  def destroy_pub_category_item_rels params
    PubCategoryItemRel.where(category: @category, item: @pub).delete_all
    render template: 'pub_category_item_rels/json/destroy.success.json.jbuilder'
  end

  def set_category
    @cat_klass = params[:category_type].classify.constantize
    @category  = @cat_klass.friendly_first params[:category_id]
  end

  def set_pub
    @pub_klass = params[:pub_type].classify.constantize
    @pub       = @pub_klass.friendly_first params[:pub_id]
  end
end