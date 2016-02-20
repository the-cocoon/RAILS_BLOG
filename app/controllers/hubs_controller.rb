class HubsController < ApplicationController
  layout 'rails_blog_layout'

  def category_klass
    ::Hub
  end

  before_action :authenticate_user!,  except: %w[ index show ]

  include ::RailsBlog::CategoryController
end