class Article < ActiveRecord::Base
  belongs_to :story
  belongs_to :day

  # put api calls (nytimes) here

  # Thinh will pass Rose an array of trending stories from Twitter.
  # Rose will iterate over that array and pull articles from the NYTimes (keyword?).

end
