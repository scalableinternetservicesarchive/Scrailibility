class AddPlaceIdToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :place_id, :string
  end
end
