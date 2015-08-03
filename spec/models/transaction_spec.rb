require 'spec_helper'

describe Transaction, type: :model do
  it "has a valid factory" do
    transaction = build(:transaction)
    expect(transaction).to be_valid
  end
end
