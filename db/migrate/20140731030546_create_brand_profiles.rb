class CreateBrandProfiles < ActiveRecord::Migration
  def self.up
    create_table :brand_profiles do |t|
      t.belongs_to :brand
      t.belongs_to :profile
      t.timestamps
    end
  end

  def self.down
    drop_table :brand_profiles
  end
end
