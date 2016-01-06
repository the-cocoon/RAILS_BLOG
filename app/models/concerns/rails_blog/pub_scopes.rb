# include ::RailsBlog::PubScopes
module RailsBlog
  module PubScopes
    extend ActiveSupport::Concern

    included do
      scope :with_users, -> { includes(:user) }
      scope :available_pub_for, ->(user = nil) { user ? for_manage : published }
    end
  end
end