class RequestHandler
  def self.create_profile(data)
    new_profile = Profile.create_profile
    self.connect_brands(data["add"], new_profile) if data["add"]
    binding.pry
    new_profile
  end

  def self.create_brand(name)
    Brand.create_brand({name: name})
  end

  def self.update_profile(data, id)
    profile = Profile.find_by(id: id)
    self.connect_brands(data["add"], profile) if data["add"]
    self.disconnect_brands(data["remove"], profile) if data["remove"]
  end

  private

  def self.connect_brands(brands, profile)
    brands.each do |brand|
      if brand['name'] || brand['id']
        if !brand['id']
          brand['id'] = self.create_brand(brand['name']).id
        end
        p profile
        p brand
        profile.connect_brand(brand['id'])
      end
    end
  end

  def self.disconnect_brands(brands, profile)
    brands.each do |brand|
      if brand['name'] || brand['id']
        if !brand['id']
          brand['id'] = self.create_brand(brand['name']).id
        end
        profile.disconnect_brand(brand['id'])
      end
    end
  end
end
