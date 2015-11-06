class CreateUserTimeslots < ActiveRecord::Migration
  def change
    create_table :user_timeslots do |t|
      t.integer :user_id
      t.integer :timeslot_id

      t.timestamps null: false
    end

    add_foreign_key :user_timeslots, :users
    add_foreign_key :user_timeslots, :timeslots
  end
end
