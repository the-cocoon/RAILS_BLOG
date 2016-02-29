module RailsBlog
  module PubController
    extend ActiveSupport::Concern

    included do
      include ::TheSortableTreeController::ReversedRebuild

      layout ->{ layout_for_action }

      before_action :set_klass
      before_action :set_pub_and_user, only: %w[
        rebuild show print edit slug view_templates update destroy
      ]
      before_action :set_prev_next_pubs, only: %w[ show ]

      # MAIN IMAGE
      before_action :user_require,   except: %w[ index show ]
      before_action :owner_required, except: %w[ index create show my manage new expand_node ]
      before_action :admin_require,  except: %w[ index show ]
    end

    # Public actions

    # def index; end

    def show
      if @pub.published? && !@pub.owner?(current_user)
        @klass.increment_counter(:view_counter, @pub.id)
      end
    end

    def print
      render layout: false, template: 'rails_blog/pubs/print'
    end

    # Restricted actions

    def my
      @pub_items = @user.send(controller_name).max2min(:id).simple_sort(params).pagination(params)
      render 'rails_blog/pubs/manage'
    end

    def new
      @pub = @klass.new
      render 'rails_blog/pubs/new'
    end

    def create
      @pub = current_user.send(controller_name).new(pub_params)
      @pub.content_processing_for(current_user)

      if @pub.save
        @pub.keep_consistency_after_create!
        redirect_to url_for([:edit, @pub]), notice: "Публикация создана"
      else
        render 'rails_blog/pubs/new'
      end
    end

    def edit
      @hubs  = current_user.hubs.nested_set.for_manage
      render 'rails_blog/pubs/edit'
    end

    def update
      @pub.assign_attributes(pub_params)
      @pub.content_processing_for(current_user)

      if @pub.save
        @pub.keep_consistency_after_update!
        redirect_to url_for([:edit, @pub]), notice: "Публикация обновлена"
      else
        @pub.update_attachment_fields(:main_image)
        render 'rails_blog/pubs/edit'
      end
    end

    def destroy
      @pub.destroy
      @pub.keep_consistency_after_destroy!
      redirect_to cabinet_url
    end

    def manage
      @pub_items = if current_user.admin?
        @klass.max2min(:id).simple_sort(params).pagination(params)
      else
        @user.send(controller_name).max2min(:id).simple_sort(params).pagination(params)
      end

      render 'rails_blog/pubs/manage'
    end

    def slug
      render 'rails_blog/pubs/slug'
    end

    def view_templates
      render 'rails_blog/pubs/view_templates'
    end

    private

    def render_custom_view opts = {}
      opts = opts.with_indifferent_access

      layout   = opts[:default_layout]
      template = opts[:default_template]
      pub      = opts[:publication]

      if pub
        layout   = pub.view_layout   if pub.view_layout.present?
        template = pub.view_template if pub.view_template.present?
      end

      if layout.present? || template.present?
        render({ layout: layout, template: template }.compact)
      end
    end

    def set_klass
      @klass      = controller_name.classify.constantize
      @klass_name = controller_name.singularize.to_sym
    end

    def pub_id
      params[:id]      ||
      params[:post_id] ||
      params[:page_id]
    end

    def set_pub_and_user
      @pub = @klass
              .with_users
              .available_pub_for(current_user)
              .friendly_first(pub_id)

      return page_404 unless @pub

      @user = @pub.user
      @owner_check_object = @pub
    end

    def set_prev_next_pubs
      return unless @pub
      base_rel = @klass.available_pub_for(current_user)
      @next_pub = base_rel.where("#{ @klass.table_name }.created_at < ?", @pub.created_at).last
      @prev_pub = base_rel.where("#{ @klass.table_name }.created_at > ?", @pub.created_at).first
    end

    # MAIN IMAGE
    def user_id
      params[:user] || params[:user_id]
    end

    def pub_params
      # TODO: user_id for create
      # TODO: user_id for update only for moderator|admin

      params.require(@klass_name).permit(
        :slug,

        :hub_id,
        :user_id,

        :main_image,

        :title,
        :raw_intro,
        :raw_content,
        :state,

        :editor_type,

        :view_layout,
        :view_template
      )
    end
  end

end