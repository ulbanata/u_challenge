class RequestHandler

  options = { :namespace => "app_v1", :compress => true }
  @@dc = Dalli::Client.new('localhost:11211', options)

  def self.grab_profile(id)
    @@dc.fetch(["profile", id]) {
      profile = Profile.find_by(id: id)
      return {error: "No profile with #{id} exists!"}.to_json unless profile
      profile.to_json(:include => :brands)
    }
  end

  def self.create_profile(data)
    new_profile = Profile.create_profile
    self.connect_brands(data["add"], new_profile) if data["add"]
    reset_profile_cache(new_profile.id)
    self.grab_profile(new_profile.id)
  end

  def self.update_profile(data, id)
    profile = Profile.find_by(id: id)
    return {error: "No profile with #{id} exists!"}.to_json unless profile
    self.connect_brands(data["add"], profile) if data["add"]
    self.disconnect_brands(data["remove"], profile) if data["remove"]
    reset_profile_cache(id)
    self.grab_profile(id)
  end

  def self.grab_brand(id)
    @@dc.fetch(["brand", id]) {
      brand = Brand.find_by(id: id)
      return {error: "No brand with #{id} exists!"}.to_json unless brand
      brand.to_json(:include => :profiles)
    }
  end

  def self.create_brand(name)
    brand = Brand.create_brand({name: name})
    self.reset_brand_cache(brand['id'])
    brand
  end

  private

  def self.connect_brands(brands, profile)
    brands.each do |brand|
      if brand['name'] || brand['id']
        if !brand['id']
          brand['id'] = self.create_brand(brand['name']).id
        end
        profile.connect_brand(brand['id'])
        self.reset_brand_cache(brand['id'])
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
        self.reset_brand_cache(brand['id'])
      end
    end
  end

  def self.reset_profile_cache(id)
    @@dc.set(["profile", id], Profile.find(id).to_json(:include => :brands) )
  end

  def self.reset_brand_cache(id)
    @@dc.set(["brand", id], Brand.find(id).to_json(:include => :profiles))
  end
end
