require_relative("../../../lib/model/item")
require_relative("../../../lib/model/product")
require_relative("../../../lib/services/fetch_product")

RSpec.describe Shop::Item do
  context "arguments" do
    it "requires a hash {product_id:, quantity:} with quantity >= 0" do
      expect{
        Shop::Item.new(product_id: nil, quantity: 0)
      }.to_not raise_error
    end

    it "raises ArgumentError when not given a hash" do
      expect{
        Shop::Item.new(nil)
      }.to raise_error(ArgumentError)
    end
  end

  context ":product_id" do
    let(:product_id) { rand(100) }

    it "assigns product_id value to variable @product_id" do
      expect(Shop::Item.new(product_id: product_id, quantity: 0).product_id).
        to eql(product_id)
    end
  end

  context ":quantity" do
    let(:quantity) { rand(100) }

    it "assigns quantity value to variable @quantity" do
      expect(Shop::Item.new(product_id: nil, quantity: quantity).quantity).
        to eql(quantity)
    end

    it "expects quantity >= 0" do
      expect{
        Shop::Item.new(product_id: nil, quantity: -1)
      }.to raise_error(ArgumentError)
    end
  end

  context ":id" do
    it "assings a fixnum id to variable @id" do
      expect(Shop::Item.new(product_id: nil, quantity: 0).id).to be_a(Fixnum)
    end
  end

  context "#next_id" do
    it "class variable @@id is incremented" do
      Shop::Item.new(product_id: nil, quantity: 0)

      expect(Shop::Item.class_variable_get(:@@id)).to be > 0
    end
  end

  context "basket views methods" do
    before do
      stub_const("Shop::PRODUCTS", [Shop::Product.new('Cat food', 3.50, 2)])
    end

    context ":fetch_product" do
      it "item id matches the product id" do
        item = Shop::Item.new(product_id: Shop::PRODUCTS[0].id, quantity: 2)
        expect(item.fetch_product).to eql(Shop::PRODUCTS[0])
      end
    end

    context ":total_net_price" do
      it "calculates the net price of a given quantity" do
        item = Shop::Item.new(product_id: Shop::PRODUCTS[0].id, quantity: 2)
        expect(item.total_net_price).to eql(7.00)
      end
    end

    context ":total_gross_price" do
      it "calculates the gross price of a given quantity" do
        item = Shop::Item.new(product_id: Shop::PRODUCTS[0].id, quantity: 2)
        expect(item.total_gross_price).to eql(7.56)
      end
    end
  end
end
