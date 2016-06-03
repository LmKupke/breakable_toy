class Venue < ActiveRecord::Base
  validates :name, presence: true, allow_nil: false, allow_blank: false
  validates :phone, presence: true, uniqueness: {message: "Number already exists!" }, allow_nil: false, allow_blank: false, length: { is: 15 }
  validates :category, presence: true, allow_nil: false
  validates :address, presence: true, length: { minimum: 4 }, allow_nil: false, allow_blank: false
  validates :city, presence: true, allow_nil: false, allow_blank: false
  validates :postal_code, presence: true, numericality: { greater_than: 0, only_integer: true }, length: { is: 5 }, allow_nil: false, allow_blank: false
  validates :state_code, presence: true, length: { is: 2 }, allow_nil: false, allow_blank: false
  validates :rating, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 5 }, allow_nil: false
  validates :latitude, presence: true, numericality: true
  validates :longitude, presence: true, numericality: true
  validates :url, presence: true, allow_nil: false, allow_blank: false, numericality: false
  validates :yelp_id, presence: true, uniqueness: true

  def full_address
    "#{self.address} #{self.city}, #{self.state_code} #{self.postal_code}"
  end

  def self.search(search)
    where("name LIKE ?", "%#{search}%")
  end
end
