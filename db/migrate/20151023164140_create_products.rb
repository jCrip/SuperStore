class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.decimal10 :price
      t.decimal2 :price
      t.integer :stock

      t.timestamps null: false
    end
  end
end
