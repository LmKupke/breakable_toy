class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :venueselection

  validates :user_id, presence: true
  validates :venueselection_id, presence: true
  validates :vote, presence: true, inclusion: { in: [1, 0, -1] }
end
