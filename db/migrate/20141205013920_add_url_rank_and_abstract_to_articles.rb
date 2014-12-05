class AddUrlRankAndAbstractToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :url, :string
    add_column :articles, :abstract, :string
    add_column :articles, :rank, :integer

  end
end
