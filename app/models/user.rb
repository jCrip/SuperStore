class User < ActiveRecord::Base
  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/

  before_save :default_role
  after_create :send_welcome_email
  after_update :send_password_change_email, if: :needs_password_change_email?

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :omniauthable, omniauth_providers: [:facebook, :twitter]


  has_many :identities, dependent: :destroy

  has_many :orders, dependent: :destroy
  has_many :reviews, dependent: :destroy

  has_many :carts, dependent: :destroy
  has_many :products, through: :carts

  has_many :likes
  has_many :product_likes, through: :likes, source: :likable, source_type: 'Product'
  has_many :review_likes, through: :likes, source: :likable, source_type: 'Review'

  validates :name, presence: true
  validates :lastname, presence: true
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validate :validate_username
  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

  enum role: [:admin, :client, :guest]

  scope :order_by_role, -> { order(:role, :id) }

  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude

  after_validation :geocode, if: ->(obj) { obj.address.present? and obj.address_changed? }
  after_validation :reverse_geocode, if: ->(obj) { (obj.latitude.present? && obj.longitude.present?) and (obj.latitude_changed? || obj.longitude_changed?) }

  def default_role
    self.role ||= 1
  end

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

  def to_s
    "#{self.name} #{self.lastname}"
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end

  private

    def self.find_for_oauth(auth, signed_in_resource = nil)
      identity = Identity.find_for_oauth(auth)
      user = signed_in_resource ? signed_in_resource : identity.user

      if user.nil?
        email = auth.info.email if auth.info.email
        user = User.where(:email => email).first if email

        if user.nil?
          if identity.provider == "twitter"
            user = User.new(
              name: auth.info.name,
              lastname: auth.info.name.split.last,
              username: auth.info.nickname,
              address: auth.info.location,
              email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
              password: Devise.friendly_token[0,20]
            )
          else
            user = User.new(
              name: auth.info.first_name,
              lastname: auth.info.last_name,
              username: auth.info.name.parameterize,
              address: auth.info.location,
              email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
              password: Devise.friendly_token[0,20]
            )
          end
          user.save!
        end
      end

      if identity.user != user
        identity.user = user
        identity.save!
      end
      user
    end

    def send_welcome_email
      UserMailer.welcome_email(self).deliver_later
    end

    def needs_password_change_email?
      encrypted_password_changed? && persisted?
    end

    def send_password_change_email
      UserMailer.password_changed(self).deliver_later(wait: 30.seconds)
    end

end
