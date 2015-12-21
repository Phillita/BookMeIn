class CreateCalendarWorkdays < ActiveRecord::Migration
  def change
    create_table :calendar_workdays do |t|
      t.integer :calendar_id
      t.integer :workday_id

      t.timestamps null: false
    end
  end
end
