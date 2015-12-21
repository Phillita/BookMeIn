class AddEventValidationFieldsToCalendar < ActiveRecord::Migration
  def change
    add_column :calendars, :validate_name, :boolean, default: false
    add_column :calendars, :validate_phone, :boolean, default: false
    add_column :calendars, :validate_comment, :boolean, default: false
  end
end
