class Workday < ActiveRecord::Base
  has_many :calendar_workdays
  has_many :calendars, through: :calendar_workdays
end
