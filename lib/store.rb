class Store < ActiveRecord::Base
  has_many :inventories
  has_many :brands, through: :inventories
end
