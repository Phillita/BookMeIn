class Event < ActiveRecord::Base
  belongs_to :calendar

  before_save :downcase_email, if: :client_email_changed?
  before_create :generate_client_email_confirm_token
  after_create :send_confirmation_email

  validates :client_email, presence: true, length: { maximum: 255 },
                           format: { with: User::VALID_EMAIL_REGEX }
  validates :calendar_id, :start_dt, :end_dt, presence: true
  validates :client_email_confirm_token, uniqueness: true
  validates :client_name, presence: true, if: :validate_name?
  validates :client_phone, presence: true, if: :validate_phone?
  validates :client_comment, presence: true, if: :validate_comment?

  private

  def downcase_email
    self.client_email = client_email.downcase
  end

  def generate_client_email_confirm_token
    loop do
      self.client_email_confirm_token = SecureRandom.hex
      break unless self.class.exists?(client_email_confirm_token: client_email_confirm_token)
    end
  end

  def send_confirmation_email
    # TODO: create the mailer
  end

  def validate_name?
    try(:calendar).try(:validate_name)
  end

  def validate_phone?
    try(:calendar).try(:validate_phone)
  end

  def validate_comment?
    try(:calendar).try(:validate_comment)
  end
end
