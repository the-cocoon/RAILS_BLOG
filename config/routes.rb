module RailsBlog
  # RailsBlog::Routes.mixin(self)
  class Routes
    def self.mixin mapper
      mapper.extend ::RailsBlog::DefaultRoutes
      mapper.send :rails_blog_routes
    end
  end

  module DefaultRoutes
    def rails_blog_routes
      resources :pub_category_item_rels do
        collection do
          post :rebuild
        end
      end

      resources :pages do
        collection do
          get :manage
        end
      end

      resources :posts do
        collection do
          get :manage
        end
      end

      resources :hubs do
        member do
          get :ordering
        end

        collection do
          get :manage
          get :tree
          post :rebuild
        end
      end

      resources :pubs do
        collection do
          get :manage
        end
      end
    end
  end
end