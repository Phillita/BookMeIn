class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.string :name
      t.integer :company_id
      t.boolean :event_verification

      t.timestamps null: false
    end
  end
end
