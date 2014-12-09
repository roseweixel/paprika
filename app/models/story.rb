require 'open-uri'
require 'date'
require 'pry'

class Story < ActiveRecord::Base
  has_many :articles
  has_many :scores

  MAX_API_CALLS = 40
  ARTICLES_PER_CALL = 20

  # returns an array of 500 most popular articles (from most to least popular)
  def get_articles
    article_array = []
    offset = 0
    MAX_API_CALLS.times do
      type = "json"
      url = "http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/30.json?offset=#{offset}&api-key=#{ENV["ny_times_most_popular_key"]}"
      response_hash = JSON.load(open(url))
      article_array = article_array + response_hash["results"]
      offset += ARTICLES_PER_CALL
    end
    article_array
  end

  def create_articles
    all_populars = get_articles
    all_populars.each_with_index do |article, rank|
      if article["title"] =~ /#{self.name}/i || article["abstract"] =~ /#{self.name}/i
        articles_for_date = Article.where(published_date: article["published_date"].to_date)
        if !articles_for_date.empty?
          articles_for_date.each do |article_for_date|
            if rank+1 < article_for_date.rank
              new_article = self.articles.find_or_create_by(:name => article["title"], :abstract => article["abstract"], :url => article["url"], :rank => rank+1, :published_date => article["published_date"].to_date)
              new_article.format_abstract
              new_article.format_name
              article_for_date.destroy
            end
          end
        else
          new_article = self.articles.find_or_create_by(:name => article["title"], :abstract => article["abstract"], :url => article["url"], :rank => rank+1, :published_date =>  article["published_date"].to_date)
          new_article.format_abstract
          new_article.format_name
        end
      end
    end
  end

end

# #{ENV[ny_times_most_popular_key]}

# /svc/mostpopular/v2/{mostemailed | mostshared | mostviewed}/
# sections-list[.response-format]?api-key={your-API-key}

# http://api.nytimes.com/svc/mostpopular/v2/mostviewed/arts/30.xml?offset=40

# http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/30.xml?offset=0&api-key=c2f0ef1ae7ae6dae568c98e040255a45:11:70265638

