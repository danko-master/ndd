class AddDefaultvalueToArticles < ActiveRecord::Migration
  def change
    change_column :articles, :name, :string, :default => "Empty name", :null => false
    change_column :articles, :description, :text, :default => "Empty description", :null => false
    change_column :articles, :fulltext, :text, :default => "Empty full text", :null => false
    change_column :articles, :date, :date, :default => "01.01.2001", :null => false
  end
end
