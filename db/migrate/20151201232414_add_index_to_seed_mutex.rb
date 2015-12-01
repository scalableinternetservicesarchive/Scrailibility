class AddIndexToSeedMutex < ActiveRecord::Migration
  def change
    add_index :seed_mutexes, :acquired, :unique => true
  end
end
