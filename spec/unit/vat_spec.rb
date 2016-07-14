require_relative("../../lib/model/vat.rb")

RSpec.describe Shop::Vat do
  it "has a list of vat rates in an array" do
    expect(Shop::Vat::LEVELS.class).to eql(Array)
  end

  it "the array has proper values" do
     expect(Shop::Vat::LEVELS).to eql([0.23, 0.08, 0.05, 0.00])
  end
end
