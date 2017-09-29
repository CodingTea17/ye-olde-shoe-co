class Store < ActiveRecord::Base
  has_many :inventories
  has_many :brands, through: :inventories

  validates(:name, {:presence => true, :length => {:maximum => 100}, uniqueness: { case_sensitive: false }})
  before_save(:capitalize_store)

private
  def capitalize_store
    self.name=(name().split.map!{|word| word.capitalize}.join(' '))
  end
end
