class AddFormattedNameToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :formatted_name, :text
  end
end
