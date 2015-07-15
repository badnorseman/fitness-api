require 'spec_helper'

describe Product, type: :model do
  it "has a valid factory" do
    product = build(:product)
    expect(product).to be_valid
  end

  it "should validate length of name" do
    product = build(:product,
                    name: "EXCEEDS MAX LENGTH" * 100)
    expect(product).to be_invalid
  end

  it "should validate length of description" do
    product = build(:product,
                    description: "EXCEEDS MAX LENGTH" * 600)
    expect(product).to be_invalid
  end
end
