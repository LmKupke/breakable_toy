class Event < ActiveRecord::Base
  paginates_per 10
  validates :date, null: false, presence: true
  validates :organizer_id, null: false, presence: true
  validates :name, null: false, presence:true
  validates :start_time, null: false, presence:true, format: { with: /\A([1-9]|1[012]) (: [0-5]\d) [AP][M]\z/ }
  validate :date_cannot_be_in_the_past

  belongs_to :organizer, class_name: "User", foreign_key: "organizer_id"
  has_many :invites, dependent: :destroy
  has_many :venueselections, dependent: :destroy

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
  def self.upcoming(user)
    where("organizer_id = ? AND date >= ?", user, Time.zone.now ).order(date: :asc, start_time: :asc)
  end

  def self.past_events(user)
    where("organizer_id = ? AND date <= ?", user, Time.zone.now ).order(date: :desc, start_time: :asc)
  end
end
