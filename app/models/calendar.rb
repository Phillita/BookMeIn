class Calendar < ActiveRecord::Base
  belongs_to :company
  has_one :api_key, dependent: :destroy
  has_many :calendar_workdays
  has_many :workdays, through: :calendar_workdays

  serialize :days_of_week

  after_create :generate_api_key

  validates :name, :business_hours_start, :business_hours_end, presence: true

  def add_and_remove_days(ids)
    calendar_workdays.destroy_all
    ids.compact!
    ids.reject!(&:blank?)
    ids = Workday.all.pluck(:id) if ids.empty?
    ids.each do |day_id|
      calendar_workdays.build(workday_id: day_id)
    end
  end

  private

  def generate_api_key
    create_api_key
  end
end
