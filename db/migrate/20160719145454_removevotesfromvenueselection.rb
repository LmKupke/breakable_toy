class Removevotesfromvenueselection < ActiveRecord::Migration
  def up
    remove_column :venueselections, :votes, :integer, null: false, default: 0
  end

  def down
    add_column :venueselections, :votes, :integer, null: false, default: 0
  end
end
