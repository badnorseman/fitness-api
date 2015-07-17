require "spec_helper"

describe PaymentPlan, type: :model do
  it "has a valid factory" do
    payment_plan = build(:payment_plan)
    expect(payment_plan).to be_valid
  end

  it "should validate name length" do
    payment_plan = build(:payment_plan,
                         name: "EXCEEDS MAX LENGTH" * 10)
    expect(payment_plan).to be_invalid
  end

  it "should validate description length" do
    payment_plan = build(:payment_plan,
                         description: "EXCEEDS MAX LENGTH" * 525)
    expect(payment_plan).to be_invalid
  end

  it "should validate currency length" do
    payment_plan = build(:payment_plan,
                         currency: "ABCD")
    expect(payment_plan).to be_invalid
  end
end
