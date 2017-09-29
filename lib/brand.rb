class Brand < ActiveRecord::Base
  has_many :inventories
  has_many :stores, through: :inventories
  validates(:name, {:presence => true, :length => {:maximum => 100}, uniqueness: { case_sensitive: false }})
  validates(:price, {:presence => true})
  before_save(:capitalize_brand, :format_money)

private
  def capitalize_brand
    self.name=(name().split.map!{|word| word.capitalize}.join(' '))
  end
  def format_money
    self.price=(sprintf('%.2f', price()))
  end
end
