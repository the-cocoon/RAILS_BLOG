class PubTagsController < RailsBlogController
  def category_klass
    ::PubTag
  end

  before_action :authenticate_user!,  except: %w[ index show ]

  include ::RailsBlog::CategoryController

  def show
    super

    render_custom_view(
      default_layout:   'rails_blog_frontend',
      default_template: 'pub_tags/show',
      publication: @pub_category
    )
  end
end