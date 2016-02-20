module RailsBlog
  module CategoryController
    extend ActiveSupport::Concern

    # include ::RailsBlog::PubController
    include ::TheSortableTreeController::Rebuild
    include ::TheSortableTreeController::ExpandNode

    included do
      before_action :set_pub_category, only: %w[ show ]
      before_action :set_editable_pub_category, only: %w[ edit update destroy ]

      # before_action :set_hub_via_pub, only: %w[ ordering ]
      # before_action :set_hub
    end

    def show
      @pub_categories = @pub_category.children.published.nested_set

      @pub_items = PubCategoryRel
                    .where(category: @pub_category)
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
      @hub.content_processing_for(current_user)

      if @hub.save
        @hub.try(:keep_consistency_after_create!)
        redirect_to url_for([:edit, @hub]), notice: "Раздел создан"
      else
        render 'hubs/new'
      end
    end

    def edit; end

    def update
      @hub.assign_attributes(hub_params)
      @hub.content_processing_for(current_user)

      if @hub.save
        @hub.try(:keep_consistency_after_update!)
        redirect_to url_for([:edit, @hub]), notice: "Раздел обновлен"
      else
        render 'hubs/edit'
      end
    end

    # Restricted area

    def manage
      @hubs = current_user.hubs.for_manage.nested_set.simple_sort(params).pagination(params)
    end

    def tree
      @hubs = current_user.hubs.for_manage.nested_set
    end

    # private

    # def set_hub_via_pub
    #   set_klass
    #   set_pub_and_user
    # end

    # def set_hub
    #   @hub = @pub
    # end

    # def hub_params
    #   # TODO: user_id for create
    #   # TODO: user_id for update only for moderator|admin

    #   @hub_state = params[:hub].try(:[], :state)
    #   params.require(:hub).permit(
    #     :user_id,
    #     :slug,

    #     :optgroup,

    #     :title,
    #     :raw_intro,
    #     :raw_content,

    #     :state
    #   )
    # end

    private

    def set_pub_category
      @pub_category = category_klass.published.friendly_first(params[:id])
      return page_404 unless @pub_category
    end

    def set_editable_pub_category
      @pub_category = category_klass.for_manage.friendly_first(params[:id])
      return page_404 unless @pub_category
    end

    def pub_category_params
      param_name = category_klass.table_name.singularize

      params.require(param_name).permit(
        :title,
        :url,
        :raw_intro,
        :raw_content,
        :state
      )
    end
  end
end