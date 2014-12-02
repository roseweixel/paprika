class Score < ActiveRecord::Base
  belongs_to :day
  belongs_to :story

  # calculate twitter count, nytimes hits here

end
