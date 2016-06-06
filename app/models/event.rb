class Event < ActiveRecord::Base
  validates :date, null: false, presence: true
  validates :organizer_id, null: false, presence: true
  validates :name, null: false, presence:true
  validates :start_time, null: false, presence:true, format: { with: /\A([1-9]|1[012]) (: [0-5]\d) [AP][M]\z/ }
  validate :date_cannot_be_in_the_past
  before_save :fix_datetime

  has_many :invites
  has_many :venueselections
  belongs_to :organizer, class_name: "User", foreign_key: "organizer_id"

  def date_cannot_be_in_the_past
    if date.present? && date < Time.zone.now
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
    date += h.to_i.hours + m.to_i.minutes + 1.minute
    self.date = date
  end
  def self.upcoming(user, datenow)
    where("organizer_id = ? AND date >= ?", user, datenow ).order(date: :asc, start_time: :asc)
  end
end
