class Invationstable < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.integer :inviter_id, null: false
      t.integer :invitee_id, null: false
      t.string :status, null: false, default: "Pending"
      t.integer :event_id, null: false
      t.timestamps null:false
    end
  end
end
