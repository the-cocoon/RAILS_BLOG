class PubTagsController < RailsBlogController
  def pub_category_klass
    ::PubTag
  end

  include ::RailsBlog::PubCategoryController

  def create_published
    @pub_category = current_user.send(pub_category_name).new(title: params[:title])
    @pub_category.content_processing_for(current_user)

    if @pub_category.save
      @pub_category.published!
      @pub_category.try(:keep_consistency_after_create!)

      render layout: false, template: 'pub_tags/json/create_published.success.json.jbuilder'
    else
      render layout: false, template: 'pub_tags/json/create_published.errors.json.jbuilder'
    end
  end

  def index
    @pub_tags = PubTag.published.min2max(:title)
  end

  def show
    super

    render_custom_view(
      default_layout:   'rails_blog_frontend',
      default_template: 'pub_tags/show',
      publication: @pub_category
    )
  end

  # =======================================
  # Restricted Area | Admin
  # =======================================

  def manage
    @pub_tags = PubTag.for_manage.min2max(:title)
  end
end