class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name, null:false
      t.string :phone, null:false
      t.string :category, null:false
      t.string :address, null: false
      t.string :city, null: false
      t.string :postal_code, null: false
      t.string :state_code, null: false
      t.integer :rating, null: false

      t.timestamps null: false
    end
  end
end
