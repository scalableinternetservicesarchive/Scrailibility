class CreateSeedMutexes < ActiveRecord::Migration
  def change
    create_table :seed_mutexes do |t|
      t.boolean :acquired

      t.timestamps null: false
    end
  end
end
