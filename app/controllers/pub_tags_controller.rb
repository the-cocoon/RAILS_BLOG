class PubTagsController < RailsBlogController
  def pub_category_klass
    ::PubTag
  end

  before_action :authenticate_user!,  except: %w[ index show ]

  include ::RailsBlog::PubCategoryController

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

  def manage
    @pub_tags = PubTag.for_manage.min2max(:title)
  end
end