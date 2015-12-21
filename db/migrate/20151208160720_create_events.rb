class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :calendar_id
      t.datetime :start_dt
      t.datetime :end_dt
      t.string :client_name
      t.string :client_email
      t.string :client_phone
      t.text :client_comment
      t.boolean :client_email_confirm, default: false
      t.string :client_email_confirm_token

      t.timestamps null: false
    end
  end
end
