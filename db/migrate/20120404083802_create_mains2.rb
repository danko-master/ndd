class CreateMains < ActiveRecord::Migration
  def change
    create_table :mains do |t|
      t.string :title, :default => "Empty string", :null => false
      t.text :content, :default => "Empty string", :null => false
      t.text :metadescription, :default => "", :null => false
      t.text :metakeywords, :default => "", :null => false
      t.text :head, :default => "", :null => false
      t.text :contact, :default => "", :null => false
      t.text :footer, :default => "", :null => false
      t.text :counter, :default => "", :null => false

      t.timestamps
    end
  end
end
