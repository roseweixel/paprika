class Score < ActiveRecord::Base
  belongs_to :day
  belongs_to :story

  # calculate twitter count here

end
