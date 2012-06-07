class AddResetCodeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :reset_code, :string, :limit => 40
  end
end
