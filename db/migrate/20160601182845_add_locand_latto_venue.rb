class AddLocandLattoVenue < ActiveRecord::Migration
  def change
    add_column :venues, :latitude, :float, null: false
    add_column :venues, :longitude, :float, null: false
    add_column :venues, :url, :string, null: false  
  end
end
