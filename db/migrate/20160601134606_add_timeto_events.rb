class AddTimetoEvents < ActiveRecord::Migration
  def change
    add_column :events, :start_time, :string, null: false
  end
end
