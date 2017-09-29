class ChangePriceToStringType < ActiveRecord::Migration[5.1]
  def change
    def change
      remove_column(:brands, :price, :integer)
      add_column(:brands, :price, :string)
    end
  end
end
