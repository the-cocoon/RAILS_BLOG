class PubCategoryRelsController < RailsBlogController
  include ::TheSortableTreeController::ReversedRebuild

  before_action :user_require,   except: %w[ ]
  before_action :owner_required, except: %w[ ]
  before_action :admin_require,  except: %w[ ]

  before_action :set_category, except: %w[ rebuild ]
  before_action :set_pub,      except: %w[ rebuild ordering ]

  def create
    checked = params[:checked].to_i == 1
    checked ? create_pub_category_rels(params) : destroy_pub_category_rels(params)
  end

  # Restricted area

  def ordering
    @category_items =
      @category
        .pub_category_rels
        .for_manage
        .reversed_nested_set
        .pagination(params)
  end

  def create_pub_category_rels params
    PubCategoryRel.create(category: @category, item: @pub)
    @pub.keep_consistency!

    respond_to do |format|
      format.json { render template: "pub_category_rels/json/#{ render_type }create.success.json.jbuilder" }
    end
  end

  def destroy_pub_category_rels params
    PubCategoryRel.where(category: @category, item: @pub).delete_all

    respond_to do |format|
      format.json { render template: "pub_category_rels/json/#{ render_type }destroy.success.json.jbuilder" }
    end
  end

  def render_type
    "#{ params[:render_type] }_" if params[:render_type]
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