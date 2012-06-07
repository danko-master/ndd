class AddIndexToArticles < ActiveRecord::Migration
  def up
    add_index :articles, :date
  end

  def down
    drop_index :articles, :date
  end
end
