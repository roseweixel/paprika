class StoriesController < ApplicationController
  def index
    @stories = Story.all
  end

  def show
    @story = Story.find(params[:id])
    @articles = @story.articles.order(:published_date)
  end
end
