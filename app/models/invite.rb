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

  def self.attending?
    status == "Attending"
  end

  def self.missing_out?
    status == "Not Attending"
  end

  def self.pending?
    status == "Pending"
  end

  def self.user_attending?(user)
    a = where("invitee_id = ? AND status = 'Attending'", user)
    if a.empty?
      false
    else
      true
    end
  end

  def self.user_notattending?(user)
    a = where("invitee_id = ? AND status = 'Not Attending'", user)
    if a.empty?
      false
    else
      true
    end
  end

  def self.user_notinvited?(user)
    a = where("invitee_id = ?", user)
    a.empty?
  end
end
