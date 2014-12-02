class Day < ActiveRecord::Base
  has_many :articles
  has_many :scores
end
