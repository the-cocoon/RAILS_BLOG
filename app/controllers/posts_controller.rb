class PostsController < RailsBlogController
  include ::RailsBlog::PubController

  def show
    super

    render_custom_view(
      default_layout:   'rails_blog_frontend',
      default_template: 'pubs/show',
      publication: @pub
    )
  end
end