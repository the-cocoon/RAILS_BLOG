class HubsController < RailsBlogController
  def pub_category_klass
    ::Hub
  end

  before_action :authenticate_user!,  except: %w[ index show ]

  include ::RailsBlog::PubCategoryController
end