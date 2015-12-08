class CalendarWorkday < ActiveRecord::Base
  belongs_to :calendar
  belongs_to :workday

  delegate :name, to: :workday
end
