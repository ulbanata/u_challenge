class Brand < ActiveRecord::Base
  has_many :brand_profiles
  has_many :profiles, :through => :brand_profiles

  def self.create_brand(data)
    if data[:name]
      brand = Brand.find_by(name: data[:name])
      return brand if brand # Single db call
      Brand.create(
        name: data[:name]
        )
    else
      nil
    end
  end
end
