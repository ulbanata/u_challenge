require_relative '../spec_helper.rb'

describe Profile do
  it 'should exist' do
    expect(Profile).to be_a(Class)
  end

  describe '.create_profile' do
    it 'should create a profile' do
      profile = Profile.create_profile
      expect(profile).to be_a(Profile)
    end
  end

  describe '#connect_brand' do
    it 'should connect a brand to a profile' do
      profile = Profile.create_profile
      brand = Brand.create_brand({name: "Pepsi"})
      profile.connect_brand(brand.id)
      expect(profile.brands.last).to eq(brand)
      expect(brand.profiles.last).to eq(profile)
    end

    it 'should return nil if a brand id is passed in that doesn\'t exist' do
      profile = Profile.create_profile
      result = profile.connect_brand(Brand.last.id + 1)
      expect(result).to be_nil
    end
  end

  describe '#disconnect_brand' do
    it 'should disconnect a brand to a profile' do
      profile = Profile.create_profile
      brand = Brand.create_brand({name: "HEB"})
      profile.connect_brand(brand.id)
      expect(profile.brands.last).to eq(brand)
      profile.disconnect_brand(brand.id)
      expect(profile.brands.empty?).to eq(true)
      expect(brand.profiles.empty?).to eq(true)
    end
  end
end
