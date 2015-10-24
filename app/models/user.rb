class User < ActiveRecord::Base

  before_save :default_role

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  has_many :orders, dependent: :destroy
  has_many :reviews, dependent: :destroy

  has_many :carts
  has_many :products, through: :carts

  validates :name, presence: true
  validates :lastname, presence: true
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validate :validate_username

  enum role: [:admin, :client, :guest]

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

end
