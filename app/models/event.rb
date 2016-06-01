class Event < ActiveRecord::Base
  validates :date, null: false, presence: true
  validates :organizer_id, null: false, presence: true
  validates :name, null: false, presence:true
  validates :start_time, null: false, presence:true, format: { with: /\A([1-9]|1[012]) (: [0-5]\d) [AP][M]\z/ }
  belongs_to :organizer, class_name: User
  validate :date_cannot_be_in_the_past

  def date_cannot_be_in_the_past
    if date.present? && date < Date.today
      errors.add(:date, "can't be in the past")
    end
  end
end
