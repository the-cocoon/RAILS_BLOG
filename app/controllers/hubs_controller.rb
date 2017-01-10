class HubsController < RailsBlogController
  def pub_category_klass
    ::Hub
  end

  include ::RailsBlog::PubCategoryController
end