class Article < ActiveRecord::Base
  belongs_to :story
  belongs_to :day

  # put api calls (nytimes) here

  # Thinh will pass Rose an array of trending stories from Twitter.
  # Rose will iterate over that array and pull articles from the NYTimes (keyword?).

  def get_datetime
    # this is how to get the date as a datetime object given a single article in the response hash from a NYTimes API call
    DateTime.iso8601(response["response"]["docs"].first["pub_date"])
  end


end
