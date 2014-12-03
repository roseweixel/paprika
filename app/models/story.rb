require 'open-uri'
require 'date'

class Story < ActiveRecord::Base
  has_many :articles
  has_many :scores

  # put api calls (twitter) here

  # we need this in cases where the name is more than one word
  def timesified_name
    name.gsub(" ", "+").downcase
  end

  # returns an array of hashes with first ten results, sorted by newest first
  def articles
    type = "json"

    url = search_url_basic

    response_hash = JSON.load(open(url))

    articles = response_hash["response"]["docs"]
  end

  def articles_back_to(date)
    type = "json"

    # increment page to get the next 10 results

    url = search_url_sorted_back_to(date) 

    response_hash = JSON.load(open(url))
    articles = response_hash["response"]["docs"]
    
    pages = number_of_pages(response_hash)

    while page <= number_of_pages

  end

  page=#{page}&

  def number_of_hits(result)
    result["response"]["meta"]["hits"]
  end

  def number_of_pages(result)
    pages = 0
    if number_of_hits(result) > 0
      if hits % 10 == 0
        pages = hits/10
      else
        pages = hits/10 + 1
      end
    end
    pages
  end

  def search_url_basic
    "http://api.nytimes.com/svc/search/v2/articlesearch.json?q=#{timesified_name}&api-key=#{ENV["ny_times_article_search_key"]}"
  end

  def search_url_sorted_newest_first
    "http://api.nytimes.com/svc/search/v2/articlesearch.json?q=#{timesified_name}&sort=newest&api-key=#{ENV["ny_times_article_search_key"]}"
  end

  # date must be passed in as YYYYMMDD (for example, 20141102)
  def search_url_sorted_back_to(date)
    "http://api.nytimes.com/svc/search/v2/articlesearch.json?q=#{self.name}&fq=document_type%3A%28%22article%22%29&begin_date=#{date}&sort=newest&api-key=#{ENV["ny_times_article_search_key"]}"
  end


end

# a query asking for isis articles going back 1 month
url = "http://api.nytimes.com/svc/search/v2/articlesearch.json?q=isis&fq=document_type%3A%28%22article%22%29&begin_date=20141102&sort=newest&api-key=842256f738ab66ba2b5de5451f23a3d9%3A8%3A70265638"

# one result looks like this
single_result = {"web_url"=>"http://www.nytimes.com/2014/12/03/world/middleeast/kurd-pact-with-baghdad-against-islamic-state.html", "snippet"=>"The agreement, which could unite Iraq against the Islamic State, covers the sharing of oil revenues with the autonomous Kurdish region.", "lead_paragraph"=>"The agreement, which could unite Iraq against the Islamic State, covers the sharing of oil revenues with the autonomous Kurdish region.", "abstract"=>nil, "print_page"=>"1", "blog"=>[], "source"=>"The New York Times", "multimedia"=>[{"width"=>190, "url"=>"images/2014/12/03/world/middleeast/03iraq/03iraq-thumbWide.jpg", "height"=>126, "subtype"=>"wide", "legacy"=>{"wide"=>"images/2014/12/03/world/middleeast/03iraq/03iraq-thumbWide.jpg", "wideheight"=>"126", "widewidth"=>"190"}, "type"=>"image"}, {"width"=>600, "url"=>"images/2014/12/03/world/middleeast/03iraq/03iraq-articleLarge.jpg", "height"=>400, "subtype"=>"xlarge", "legacy"=>{"xlargewidth"=>"600", "xlarge"=>"images/2014/12/03/world/middleeast/03iraq/03iraq-articleLarge.jpg", "xlargeheight"=>"400"}, "type"=>"image"}, {"width"=>75, "url"=>"images/2014/12/03/world/middleeast/03iraq/03iraq-thumbStandard.jpg", "height"=>75, "subtype"=>"thumbnail", "legacy"=>{"thumbnailheight"=>"75", "thumbnail"=>"images/2014/12/03/world/middleeast/03iraq/03iraq-thumbStandard.jpg", "thumbnailwidth"=>"75"}, "type"=>"image"}], "headline"=>{"main"=>"Iraqi Government and Kurds Reach Deal to Share Oil Revenues", "print_headline"=>"Iraq Government Reaches Accord With the Kurds "}, "keywords"=>[{"rank"=>"1", "is_major"=>"N", "name"=>"subject", "value"=>"Kurds"}, {"rank"=>"2", "is_major"=>"N", "name"=>"organizations", "value"=>"Islamic State in Iraq and Syria (ISIS)"}, {"rank"=>"3", "is_major"=>"N", "name"=>"organizations", "value"=>"Pesh Merga"}, {"rank"=>"4", "is_major"=>"N", "name"=>"persons", "value"=>"Abadi, Haider al-"}, {"rank"=>"5", "is_major"=>"N", "name"=>"glocations", "value"=>"Iraq"}, {"rank"=>"6", "is_major"=>"N", "name"=>"glocations", "value"=>"Erbil (Iraq)"}], "pub_date"=>"2014-12-03T00:00:00Z", "document_type"=>"article", "news_desk"=>"Foreign", "section_name"=>"World", "subsection_name"=>"Middle East", "byline"=>{"person"=>[{"organization"=>"", "role"=>"reported", "firstname"=>"Tim", "rank"=>1, "lastname"=>"ARANGO"}], "original"=>"By TIM ARANGO"}, "type_of_material"=>"News", "_id"=>"547dbe0b38f0d822abda2b1f", "word_count"=>"1156"}
