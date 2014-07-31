class Profile < ActiveRecord::Base
  has_many :brand_profiles
  has_many :brands, :through => :brand_profiles

  def self.add_profile
    Profile.create
  end
end
