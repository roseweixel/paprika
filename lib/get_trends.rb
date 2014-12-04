class GetTrends
  attr_reader :client, :results

  def initialize
    @woeid = 2459115 #NYC World ID
    @client = self.make_connection
    @results = self.make_results
  end

  def make_connection
    Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["twitter_consumer_key"]
      config.consumer_secret = ENV["twitter_consumer_secret"]
      config.access_token = ENV["twitter_access_token"]
      config.access_token_secret = ENV["twitter_access_token_secret"]
    end
  end

  def make_results
    @results = Array.new
    @client.trends(id = @woeid, options = {}).each do |trend|
      @results.push(trend.name)
    end
    return @results
  end
  
end