class Story < ActiveRecord::Base
  has_many :articles
  has_many :scores

  # put api calls (twitter) here

end
