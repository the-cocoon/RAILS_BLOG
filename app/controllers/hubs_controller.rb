class HubsController < ApplicationController
  include ::PubController
  include ::TheSortableTreeController::Rebuild
  include ::TheSortableTreeController::ExpandNode

  before_action :set_hub_via_pub, only: %w[ ordering ]
  before_action :set_hub

  layout 'rails_blog_layout'

  def show
    @hubs = @hub.children.published.nested_set

    @pub_items = HubItemRel
                  .where(hub: @hub)
                  .includes(:item)
                  .published
                  .reversed_nested_set
                  .simple_sort(params)
                  .pagination(params)

    render template: 'hubs/show'
  end

  # Restricted area

  def new
    @hub = Hub.new
  end

  def create
    @hub = current_user.hubs.new(hub_params)

    if @hub.save
      redirect_to url_for([:edit, @hub]), notice: "Раздел создан"
    else
      render template: :new
    end
  end

  def edit; end

  def update
    if @hub.update(hub_params)
      @hub.send "#{ @hub_state }!" if @hub_state
      redirect_to url_for([:edit, @hub]), notice: "Раздел обновлен"
    else
      @hub.update_attachment_fields(:main_image)
    end
  end

  # Restricted area

  def manage
    @hubs = current_user.hubs.for_manage.nested_set.simple_sort(params).pagination(params)
  end

  def tree
    @hubs = current_user.hubs.for_manage.nested_set
  end

  def ordering
    @pub_items = @hub.hub_item_rels.reversed_nested_set
  end

  private

  def set_hub_via_pub
    set_klass
    set_pub_and_user
  end

  def set_hub
    @hub = @pub
  end

  def hub_params
    # TODO: user_id for create
    # TODO: user_id for update only for moderator|admin

    @hub_state = params[:hub].try(:[], :state)
    params.require(:hub).permit(
      :user_id,
      :slug,

      :main_image,
      :optgroup,

      :title,
      :raw_intro,
      :raw_content
    )
  end
end