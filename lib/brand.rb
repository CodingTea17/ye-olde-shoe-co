class Brand < ActiveRecord::Base
  has_many :inventories
  has_many :stores, through: :inventories
  validates(:name, {:presence => true, :length => {:maximum => 25}})
  before_save(:capitalize_brand)

private
  def capitalize_brand
    self.name=(name().split.map!{|word| word.capitalize}.join(' '))
  end
end
