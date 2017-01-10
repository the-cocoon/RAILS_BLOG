# include ::RailsBlog::PubCategoryController

module RailsBlog
  module PubCategoryController
    extend ActiveSupport::Concern

    include ::RailsBlog::CustomRenderView
    include ::TheSortableTreeController::Rebuild
    include ::TheSortableTreeController::ExpandNode

    included do
      layout ->{ layout_for_action }

      before_action :set_pub_category, only: %w[ show ]
      before_action :set_editable_pub_category, only: %w[ edit update destroy ]
    end

    # =======================================
    # Public
    # =======================================

    def show
      @pub_categories = @pub_category.children.published.nested_set

      if @pub_category.published? && !@pub_category.owner?(current_user)
        pub_category_klass.increment_counter(:view_counter, @pub_category.id)
      end

      @pub_items = PubCategoryRel
                    .where(category: @pub_category)
                    .includes(:item)
                    .published
                    .reversed_nested_set
                    .simple_sort(params)
                    .pagination(params)
    end

    # =======================================
    # Restricted Area | User
    # =======================================

    def new
      @pub_category = pub_category_klass.new
    end

    def create
      @pub_category = current_user.send(pub_category_name).new(pub_category_params)
      @pub_category.content_processing_for(current_user)

      if @pub_category.save
        @pub_category.try(:keep_consistency_after_create!)
        pub_category_create_success
      else
        pub_category_create_failure
      end
    end

    def edit; end

    def update
      @pub_category.assign_attributes(pub_category_params)
      @pub_category.content_processing_for(current_user)

      if @pub_category.save
        @pub_category.try(:keep_consistency_after_update!)
        pub_category_update_success
      else
        pub_category_reset_changes
        pub_category_update_failure
      end
    end

    def destroy
      @pub_category.destroy
      @pub_category.try(:keep_consistency_after_destroy!)
      redirect_to [:manage, pub_category_name]
    end

    # =======================================
    # Restricted Area | Admin
    # =======================================

    def manage
      @pub_categories = current_user.send(pub_category_name).for_manage.nested_set.simple_sort(params).pagination(params)
    end

    def tree
      @pub_categories = current_user.send(pub_category_name).for_manage.nested_set
    end

    private

    # =======================================
    # Common
    # =======================================

    def pub_category_name
      pub_category_klass.name.tableize
    end

    def set_pub_category
      @pub_category = pub_category_klass.published.friendly_first(params[:id])
      return page_404 unless @pub_category
    end

    def set_editable_pub_category
      @pub_category = pub_category_klass.for_manage.friendly_first(params[:id])
      return page_404 unless @pub_category
    end

    def pub_category_reset_changes
      if @pub_category.changes[:slug]
        @pub_category.slug = @pub_category.changes[:slug].first
      end
    end

    def pub_category_params
      param_name = pub_category_klass.table_name.singularize

      params.require(param_name).permit(
        :title,
        :slug,
        :raw_intro,
        :raw_content,
        :state
      )
    end

    # =======================================
    # RESPONDERS
    # =======================================

    def pub_category_create_success
      respond_to do |format|
        format.html do
          redirect_to url_for([:edit, @pub_category]), notice: "Раздел создан"
        end

        format.js do
          render layout: false,
            template: "#{ pub_category_name }/json/create.success.json.jbuilder"
        end
      end
    end

    def pub_category_create_failure
      respond_to do |format|
        format.html do
          render "#{ pub_category_name }/new"
        end

        format.js do
          render layout: false,
            template: "#{ pub_category_name }/json/create.errors.json.jbuilder", status: 422
        end
      end
    end

    def pub_category_update_success
      respond_to do |format|
        format.html do
          redirect_to url_for([:edit, @pub_category]), notice: "Раздел обновлен"
        end

        format.js do
          render layout: false,
            template: "#{ pub_category_name }/json/update.success.json.jbuilder"
        end
      end
    end

    def pub_category_update_failure
      respond_to do |format|
        format.html do
          render "#{ pub_category_name }/edit"
        end

        format.js do
          render layout: false,
            template: "#{ pub_category_name }/json/update.errors.json.jbuilder", status: 422
        end
      end
    end

  end # PubCategoryController
end # RailsBlog