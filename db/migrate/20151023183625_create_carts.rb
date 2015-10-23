class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.references :product, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
