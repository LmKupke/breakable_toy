class AddtimezoneToUser < ActiveRecord::Migration
  def change
    add_column :users, :timezone, :float, null:false
  end
end
