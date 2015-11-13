class AddIndexToProfile < ActiveRecord::Migration
  def change
    add_index :profiles, :place_id
  end
end
