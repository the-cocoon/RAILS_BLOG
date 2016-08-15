class RailsBlogController < ApplicationController
  # USE THIS METHODS WHEN YOU NEED TO SKIP AUTH FILTERS
  #
  # skip_before_filter :authenticate_user!,   only: [:method_name]
  # skip_before_filter :blog_admin_required!, only: [:method_name]

  before_action :authenticate_user!,   except: %w[ index show ]
  before_action :blog_admin_required!, except: %w[ index show ]
  before_action :owner_required,       except: %w[ index show ]

  layout ->{ layout_for_action }

  private

  def blog_admin_required!
    redirect_to root_path unless current_user.try(:admin?)
  end

  def layout_for_action
    return 'rails_blog_frontend' if %w[ index show ].include?(action_name)
    'rails_blog_backend'
  end
end