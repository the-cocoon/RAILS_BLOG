class PagesController < RailsBlogController
  include ::RailsBlog::PubController
  after_filter :cors_set_access_control_headers

  # For all responses in this controller, return the CORS access control headers.

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin']  = '*'
    headers['Access-Control-Allow-Methods'] = '*'
    headers['Access-Control-Allow-Headers'] = '*'
    headers['Access-Control-Allow-Credentials'] = true

    headers["X-Frame-Options"] = "ALLOW-FROM http://www.getrix.ru"
    # headers.delete("X-Content-Type-Options")
    # headers.delete("X-XSS-Protection")

    # response.headers.except! 'X-Frame-Options'
  end

  def show
    super

    render_custom_view(
      default_layout:   'rails_blog_frontend',
      default_template: 'pubs/show',
      publication: @pub
    )
  end
end
