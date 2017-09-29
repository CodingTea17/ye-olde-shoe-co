class Brand < ActiveRecord::Base
  has_many :inventories
  has_many :stores, through: :inventories
end
