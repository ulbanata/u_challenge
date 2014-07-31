require_relative '../spec_helper.rb'

describe Brand do
  it "should exist" do
    expect(Brand).to be_a(Class)
  end

  describe ".create_brand" do
    it "should create a brand when passed a name" do
      brand = Brand.create_brand({name: "Brand"})
      expect(brand).to be_a(Brand)
      expect(Brand.find_by(name: "Brand")).to eq(brand)
      expect(brand.name).to eq("Brand")
    end

    it "should not create a new brand if a brand already exists" do
      brand = Brand.create_brand({name: "Coke"})
      brand_count = Brand.count

      brand2 = Brand.create_brand({name: "Coke"})

      expect(brand2).to eq(brand)
      expect(brand_count).to eq(Brand.count)
    end

    it "should return nil if no name is given for the brand" do
      nil_brand = Brand.create_brand({})

      expect(nil_brand).to be_nil
    end
  end
end
