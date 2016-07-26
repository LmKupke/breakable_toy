class Notification < ActiveRecord::Base
  validates :event_id, presence: true, allow_nil: false, allow_blank: false
  validates :user_id, presence: true, allow_nil: false, allow_blank: false, uniqueness: { scope: :event_id }
  validates :ping, presence: true

  validates :user, presence: true
  validates :event, presence: true

  belongs_to :event
  belongs_to :user
end
