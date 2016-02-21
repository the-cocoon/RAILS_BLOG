class PubTagsController < RailsBlogController
  def category_klass
    ::PubTag
  end

  before_action :authenticate_user!,  except: %w[ index show ]

  include ::RailsBlog::CategoryController
end