class CreateInventories < ActiveRecord::Migration[5.1]
  def change
    create_table(:inventories) do |t|
      t.column(:store_id, :integer)
      t.column(:brand_id, :integer)
      t.column(:in_stock, :boolean)
      t.column(:quantity, :integer)

      t.timestamps()
    end
  end
end
