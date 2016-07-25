class Add < ActiveRecord::Migration
  def change
    add_column(:users, :phonenumber, :string, default: nil )
  end
end
