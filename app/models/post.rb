class Post < ActiveRecord::Base
  include ::RailsBlog::PublicationModel
end