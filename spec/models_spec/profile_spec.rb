require_relative '../spec_helper.rb'

describe Profile do
  it 'should exist' do
    expect(Profile).to be_a(Class)
  end

  describe '.add_profile' do
    it 'should create a profile' do
      profile = Profile.add_profile
      expect(profile).to be_a(Profile)
    end
  end
end
