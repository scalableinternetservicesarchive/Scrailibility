class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :nick_name
      t.decimal :age, precision:4 
      t.decimal :height, precision:4
      t.decimal :weight, precision:4

      t.timestamps null: false
    end
  end
end
