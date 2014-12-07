class StoriesController < ApplicationController
  def index
    @stories = Story.all
  end

  def show
    @story = Story.find(params[:id])
    @articles = @story.articles.order(:published_date)

    @earliest_date = @articles.first.published_date
    @latest_date = @articles.last.published_date
    @data = Array.new

    @earliest_date.to_date.upto(@latest_date.to_date) do |date|
      art = @story.articles.where(published_date: date.to_datetime)
      if art.size > 0
        @data.push(art.first)
      else
        dummy = {published_date: date.to_datetime, rank: 795 }
        @data.push(dummy)
      end 
    end

    render json: @data
  end
end
