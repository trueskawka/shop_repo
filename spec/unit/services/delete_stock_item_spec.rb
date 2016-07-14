require_relative '../../../lib/services/delete_stock_item'

RSpec.describe Shop::DeleteItemFromWarehouse do
  subject(:warehouse) { Shop::DeleteItemFromWarehouse.new }

  before do
    allow(Shop).to receive(:WAREHOUSE).and_return([])
    Shop::WAREHOUSE.clear
  end

  describe "#call" do
    context "invalid id" do
      it "raises no error" do
        expect {
          warehouse.call(nil)
        }.to_not raise_error
      end
    end

    context "valid id" do
      let(:quantity) { 10 }
      let!(:add_to_warehouse) { Shop::WAREHOUSE << Shop::Item.new(product_id: 1, quantity: quantity) }
      let(:first_warehouse) { Shop::WAREHOUSE.first }

      it "reduce quantity" do
        expect {
          warehouse.call(first_warehouse.id)
        }.to change{ first_warehouse.quantity }.from(quantity).to(quantity-1)
      end
    end
  end
end
