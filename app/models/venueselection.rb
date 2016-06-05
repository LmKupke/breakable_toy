class Venueselection < ActiveRecord::Base

  belongs_to :users, :events, :venues
end
