class Invite < ActiveRecord::Base
  validates :inviter_id, presence: true, allow_nil: false, allow_blank: false
  validates :invitee_id, presence: true, allow_nil: false, allow_blank: false
  validates :status, presence: true, allow_nil: false, allow_blank: false, inclusion: { in: ["Attending","Pending", "Not Attending"] }
  validates :event_id, presence: true, allow_nil: false, allow_blank: false
  belongs_to :event
  belongs_to :inviter, class_name: "User", foreign_key: "inviter_id"
  belongs_to :invitee, class_name: "User", foreign_key: "invitee_id"

  def self.upcomingpend(user)
    a = where("invitee_id = ? AND status = 'Pending'", user)
    pending_invites = a.select do |invites|
      invites.event.date > Time.zone.now
    end
    pending_invites.sort_by do |t|
      t.event.date
    end
  end
  
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
