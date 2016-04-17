class RailsBlogController < ApplicationController
  layout ->{ layout_for_action }

  private

  def layout_for_action
    if %w[ index show ].include?(action_name)
      return 'rails_blog_frontend'
    end

    'rails_blog_backend'
  end
end