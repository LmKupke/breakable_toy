class Venueselection < ActiveRecord::Base
  validates :event_id, presence: true, allow_nil: false, allow_blank: false
  validates :user_id, presence: true, allow_nil: false, allow_blank: false
  validates :venue_id, presence: true, allow_nil: false, allow_blank: false
  validates :user, presence: true
  validates :event, presence: true
  validates :venue, presence: true

  has_many :votes
  belongs_to :user
  belongs_to :event
  belongs_to :venue
end
