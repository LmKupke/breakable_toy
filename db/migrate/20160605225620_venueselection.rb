class Venueselection < ActiveRecord::Migration
  def change
    create_table :venueselections do |t|
      t.integer :event_id, null: false
      t.integer :user_id, null: false
      t.integer :venue_id, null: false
      t.integer :votes, null: false, default: 0
    end
  end
end
