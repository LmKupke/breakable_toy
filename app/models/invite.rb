class Invite < ActiveRecord::Base
  validates :inviter_id, presence: true, allow_nil: false, allow_blank: false
  validates :invitee_id, presence: true, allow_nil: false, allow_blank: false
  validates :status, presence: true, allow_nil: false, allow_blank: false
  validates :event_id, presence: true, allow_nil: false, allow_blank: false

  belongs_to :event
  belongs_to :inviter, class_name: "User", foreign_key: "inviter_id"
  belongs_to :invitee, class_name: "User", foreign_key: "invitee_id"

  def attending?
    status == "Attending"
  end

  def missing_out?
    status == "Not Attending"
  end

  def pending?
    status == "Pending"
  end
end
