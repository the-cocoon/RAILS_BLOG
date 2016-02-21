class RailsBlogController < ApplicationController
  layout ->{ layout_for_action }

  private

  def layout_for_action
    if %w[ index show ].include? action_name
      'rails_blog_layout'
    else
      'rails_blog_backend'
    end
  end
end