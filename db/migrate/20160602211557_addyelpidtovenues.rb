class Addyelpidtovenues < ActiveRecord::Migration
  def change
    add_column :venues, :yelp_id, :string, null: false
  end
end
