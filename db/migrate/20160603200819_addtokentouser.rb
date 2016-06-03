class Addtokentouser < ActiveRecord::Migration
  def change
    add_column :users, :token, :string, null: false
    add_column :users, :expires_at, :integer, null: false
  end
end
