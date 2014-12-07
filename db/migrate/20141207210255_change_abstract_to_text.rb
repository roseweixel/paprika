class ChangeAbstractToText < ActiveRecord::Migration
  def change
    change_column :articles, :abstract, :text
  end
end
