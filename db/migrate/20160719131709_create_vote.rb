class CreateVote < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :user_id, null: false
      t.integer :venueselection_id, null: false
      t.integer :vote, default: 0, null: false
      t.timestamps null: false
    end
  end
end
