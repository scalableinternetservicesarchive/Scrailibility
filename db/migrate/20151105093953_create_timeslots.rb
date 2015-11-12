class CreateTimeslots < ActiveRecord::Migration
  def change
    create_table :timeslots do |t|
      t.time :begintime

      t.timestamps null: false
    end
  end
end
