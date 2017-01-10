class PubTag < ActiveRecord::Base
  include ::RailsBlog::CategoryModel
  validates :title, uniqueness: true
end