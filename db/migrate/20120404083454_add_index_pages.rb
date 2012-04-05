class AddIndexPages < ActiveRecord::Migration
  def up
    add_index :pages, :id
  end

  def down
    drop_index :pages, :id
  end
end
