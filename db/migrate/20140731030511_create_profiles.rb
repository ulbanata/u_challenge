class CreateProfiles < ActiveRecord::Migration
  def up
    create_table :profiles do |t|
      t.timestamps
    end
  end
end
