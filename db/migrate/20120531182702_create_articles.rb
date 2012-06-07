class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :name
      t.text :description
      t.text :fulltext
      t.date :date

      t.timestamps
    end
  end
end
