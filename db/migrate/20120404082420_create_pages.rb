class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :name, :default => "Empty string"
      t.string :title, :default => "Empty string"
      t.text :metadescription, :default => ""
      t.text :metakeywords, :default => ""
      t.text :head, :default => ""
      t.text :content, :default => "Empty string"
      t.boolean :ismenu, :default => false

      t.timestamps
    end
  end
end
