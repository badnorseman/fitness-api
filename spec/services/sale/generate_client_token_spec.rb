describe Sale::GenerateClientToken do
  it "should have a client token" do
    client_token = Sale::GenerateClientToken.new.client_token

    expect(client_token).to be_truthy
  end
end
