class FixAbstractColumn < ActiveRecord::Migration
  def change
    remove_column :articles, :abstract
    add_column :articles, :abstract, :text
  end
end
