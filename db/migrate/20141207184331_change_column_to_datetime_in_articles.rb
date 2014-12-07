class ChangeColumnToDatetimeInArticles < ActiveRecord::Migration
  def change
    change_column :articles, :published_date, :datetime
  end
end
