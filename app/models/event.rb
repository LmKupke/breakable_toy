class Event < ActiveRecord::Base
  validates :date, null: false, presence: true
  validates :organizer_id, null: false, presence: true
  validates :name, null: false, presence:true
  belongs_to :organizer, class_name: User

end
