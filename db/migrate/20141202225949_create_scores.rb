class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :popularity_score
      t.integer :story_id
      t.integer :day_id
      t.timestamps
    end
  end
end
