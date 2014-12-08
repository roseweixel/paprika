require 'open-uri'
require 'date'
require 'pry'

class Story < ActiveRecord::Base
  has_many :articles
  has_many :scores

  # returns an array of 800 most popular articles (from most to least popular)
  def get_most_populars
    article_array = []
    offset = 0
    for i in 1..40
      type = "json"
      url = "http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/30.json?offset=#{offset}&api-key=#{ENV["ny_times_most_popular_key"]}"
      response_hash = JSON.load(open(url))
      article_array = article_array + response_hash["results"]
      offset += 20
    end
    article_array
  end

  # creates Article objects
  def create_articles_for_story
    all_populars = get_most_populars
    all_populars.each_with_index do |article, rank|
      if article["title"] =~ /#{self.name}/i || article["abstract"] =~ /#{self.name}/i
        self.articles.find_or_create_by(:name => article["title"], :abstract => article["abstract"], :url => article["url"], :rank => rank+1, :published_date =>  DateTime.iso8601(article["published_date"]))
      end
    end
  end
