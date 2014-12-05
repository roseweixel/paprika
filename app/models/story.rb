require 'open-uri'
require 'date'
require 'pry'

class Story < ActiveRecord::Base
  has_many :articles
  has_many :scores

  # returns an array of 500 most popular articles (from most to least popular)
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

  def create_articles_for_story
    all_populars = get_most_populars
    all_populars.each_with_index do |article, rank|
      if article["title"] =~ /#{self.name}/i || article["abstract"] =~ /#{self.name}/i
        self.articles.find_or_create_by(:name => article["title"], :abstract => article["abstract"], :url => article["url"], :rank => rank+1, :published_date => article["published_date"])
      end
    end
  end
  # def articles
  #   type = "json"

  #   url = search_url_basic

  #   response_hash = JSON.load(open(url))

  #   articles = response_hash["response"]["docs"]
  # end

  # def search_url_basic
  #   "http://api.nytimes.com/svc/search/v2/articlesearch.json?q=#{timesified_name}&api-key=#{ENV["ny_times_article_search_key"]}"
  # end

  def make_articles_for(get_most_populars)
    # iterate over the most populars looking for self.name
      # GO THROUGH THESE STEPS AND WHEN FOUND, MAKE ARTICLE
      # look in the title
      # look in the abstract
      # whatever else there is to look in
    # parse the 'rank' (the index in the array), the date, and the article object itself
  end

end

# #{ENV[ny_times_most_popular_key]}

# /svc/mostpopular/v2/{mostemailed | mostshared | mostviewed}/
# sections-list[.response-format]?api-key={your-API-key}

# http://api.nytimes.com/svc/mostpopular/v2/mostviewed/arts/30.xml?offset=40

# http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/30.xml?offset=0&api-key=c2f0ef1ae7ae6dae568c98e040255a45:11:70265638

