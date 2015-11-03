class User < ActiveRecord::Base

  before_save :default_role
  after_create :send_welcome_email

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


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

  enum role: [:admin, :client, :guest]

  default_scope { order(:role, :id) }

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

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_later
  end

end
