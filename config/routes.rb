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
      get "pubs_ordering/:category_type/:category_id",
        action: :ordering,
        controller: :pub_category_rels,
        as: :pubs_ordering

      resources :pub_category_rels do
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
        collection do
          get :manage
          get :tree
          post :rebuild
        end
      end

      resources :pub_tags do
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