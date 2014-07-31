class Profile < ActiveRecord::Base
  has_many :brand_profiles
  has_many :brands, :through => :brand_profiles

  def self.create_profile
    Profile.create
  end

  def connect_brand(brand_id)
    #Using .find_by to ignore error thrown by .find if id not found
    brand = Brand.find_by(id: brand_id)
    if brand
      self.brands << brand
    else
      nil
    end
  end

  def disconnect_brand(brand_id)
    #Using .find_by to ignore error thrown by .find if id not found
    brand = Brand.find_by(id: brand_id)
    if brand
      self.brands.delete(brand)
    else
      nil
    end
  end
end
