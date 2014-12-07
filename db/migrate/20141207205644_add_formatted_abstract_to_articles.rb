class AddFormattedAbstractToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :formatted_abstract, :text
  end
end
