class CreateBrandProfiles < ActiveRecord::Migration
  def up
    create_table :brand_profiles do |t|
      t.belongs_to :brand
      t.belongs_to :profile
      t.timestamps
    end
  end
end
