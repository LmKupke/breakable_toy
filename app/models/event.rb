class Event < ActiveRecord::Base
  validates :date, null: false, presence: true
  validates :organizer_id, null: false, presence: true
  validates :name, null: false, presence:true
  validates :start_time, null: false, presence:true, format: { with: /\A([1-9]|1[012]) (: [0-5]\d) [AP][M]\z/ }
  validate :date_cannot_be_in_the_past
  before_validation :fix_datetime

  belongs_to :organizer, class_name: "User", foreign_key: "organizer_id"
  has_many :invites

  def date_cannot_be_in_the_past
    if date.present? && date < DateTime.now
      errors.add(:date, "can't be in the past")
      errors.add(:start_time, "time has to be later if same day")
    end
  end

  def fix_datetime
    date = self.date
    time = self.start_time
    time = time.to_datetime.strftime("%R")
    h = time[0,2]
    m = time[-2..-1]
    self.date = date + h.to_i.hours + m.to_i.minutes
  end
end
