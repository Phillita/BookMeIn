class AddCalendarOptionsToCalendar < ActiveRecord::Migration
  def change
    add_column :calendars, :business_hours_start, :time
    add_column :calendars, :business_hours_end, :time
    add_column :calendars, :editable, :boolean
    add_column :calendars, :event_buffer_time, :integer
  end
end
