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

  def format_abstract
    abstract_array = self.abstract.split(" ")
    formatted_abstract = Array.new
    abstract_array.each_with_index do |word, index|
      formatted_abstract << word
      if index % 7 == 0 && index > 0 && abstract_array[index+2]
        formatted_abstract << '<br>'
      end
    end
    formatted_abstract = formatted_abstract.join(" ")
    self.update(formatted_abstract: formatted_abstract)
  end

  def format_name
    name_array = self.name.split(" ")
    formatted_name = Array.new
    name_array.each_with_index do |word, index|
      formatted_name << word
      if index % 7 == 0 && index > 0
        formatted_name << '<br>'
      end
    end
    formatted_name = formatted_name.join(" ")
    self.update(formatted_name: formatted_name)
  end



end
