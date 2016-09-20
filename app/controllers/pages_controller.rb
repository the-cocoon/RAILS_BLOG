class PagesController < RailsBlogController
  include ::RailsBlog::PubController
  after_filter :cors_set_access_control_headers

  # For all responses in this controller, return the CORS access control headers.

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin']  =  'http://www.getrix.ru'
    headers['Access-Control-Allow-Methods'] = 'POST, GET'
    headers['Access-Control-Allow-Headers'] = '*'
    headers['Access-Control-Max-Age'] = "1728000"

    headers.delete("X-Frame-Options")
    headers.delete("X-Content-Type-Options")
    headers.delete("X-XSS-Protection")
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
