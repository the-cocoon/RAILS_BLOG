_root_ = File.expand_path('../../', __FILE__)

require "rails_blog/version"

module RailsBlog
  class Engine < Rails::Engine
    config.autoload_paths << "#{ config.root }/app/mailers/concerns/"

    initializer :add_rails_blog_view_paths do
      ActiveSupport.on_load(:action_controller) do
        _root_  = ::RailsBlog::Engine.config.root
        views_1 = "app/views/rails_blog"
        prepend_view_path("#{ _root_ }/#{ views_1 }" ) if respond_to?(:prepend_view_path)
      end
    end
  end
end

require "#{ _root_ }/config/routes"