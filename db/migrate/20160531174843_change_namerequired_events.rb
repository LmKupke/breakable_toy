class ChangeNamerequiredEvents < ActiveRecord::Migration
  def change
    change_column :events, :name, :string, null: false
  end
end
