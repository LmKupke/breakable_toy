class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :date, null: false
      t.string :name
      t.integer :organizer_id, null: false

      t.timestamps null: false
    end
  end
end
