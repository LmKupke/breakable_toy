class Venueselection < ActiveRecord::Base

  belongs_to :users
  belongs_to :events
  belongs_to :venues
end
