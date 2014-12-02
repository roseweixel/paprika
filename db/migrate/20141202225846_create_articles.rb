class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :name
      t.references :story, index: true
      t.references :day, index: true

      t.timestamps
    end
  end
end
