class CreateStoreOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :store_orders do |t|
      t.references :store, foreign_key: true
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
