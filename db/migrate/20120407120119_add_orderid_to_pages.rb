class AddOrderidToPages < ActiveRecord::Migration
  def change
    add_column :pages, :order_id, :int, :default => -1, :null => false
    add_column :pages, :parent_id, :int, :default => -1, :null => false
  end
end
