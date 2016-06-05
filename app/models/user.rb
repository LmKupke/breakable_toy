class User < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true, allow_nil: false, format: { with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }

  has_many :events, foreign_key: "organizer_id"
  has_many :invites, class_name: "User", as: :inviter_id
  has_many :invites, class_name: "User", as: :invitee_id
  has_many :venueselections
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook]


 def self.from_omniauth(auth)

   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
     user.email = auth.info.email
     user.password = Devise.friendly_token[0,20]
     user.name = auth.info.name   # assuming the user model has a name
     user.photo = auth.info.image # assuming the user model has an image
     user.token = auth.credentials.token
     user.expires_at = Time.at(auth.credentials.expires_at)
     user.timezone = auth.extra.raw_info.timezone
   end
 end

  def self.new_with_session(params, session)

    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def admin?
    role == "admin"
  end

  def moderator?
    role == "moderator"
  end
end
