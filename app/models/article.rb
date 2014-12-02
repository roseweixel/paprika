class Article < ActiveRecord::Base
  belongs_to :story
  belongs_to :day
end
