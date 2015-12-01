class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable, :confirmable

  before_save :downcase_email, if: :email_changed?
  before_create :create_company, unless: :company_id

  belongs_to :company

  validates :first_name, :last_name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: { minimum: 6 }

  def name
    "#{first_name} #{last_name}"
  end

  def guest?
    id.blank?
  end

  private

  def downcase_email
    self.email = email.downcase
  end

  def create_company
    self.company_id = Company.create.id
  end
end
