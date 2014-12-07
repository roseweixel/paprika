class Article < ActiveRecord::Base
  belongs_to :story
  belongs_to :day

  # put api calls (nytimes) here

  # Thinh will pass Rose an array of trending stories from Twitter.
  # Rose will iterate over that array and pull articles from the NYTimes (keyword?).

  def get_datetime
    # this is how to get the date as a datetime object given a single article in the response hash from a NYTimes API call
    DateTime.iso8601(published_date)
  end

  def name_string
    name.gsub("&#8217;", "'")
  end


end
