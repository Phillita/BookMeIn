class CreateWorkdays < ActiveRecord::Migration
  def change
    create_table :workdays do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
