require_relative("../../../lib/model/product.rb")

RSpec.describe Shop::Product do
  context "arguments" do
    it "requires at least two arguments" do
      expect{
        Shop::Product.new(nil, 1)
      }.to_not raise_error
    end

    it "raises ArgumentError when there are less than 2 arguments" do
      expect{
        Shop::Product.new(nil)
      }.to raise_error(ArgumentError)
    end

    it "raises ArgumentError when there are more than 3 arguments" do
      expect{
        Shop::Product.new(nil, 1, nil, nil)
      }.to raise_error(ArgumentError)
    end
  end

  context ":name" do
    let(:name) { rand(100) }

    it "assigns name value to variable @name" do
      expect(Shop::Product.new(name, 1).name).to eql(name)
    end
  end

  context ":price" do
    #as to not be == 0
    let(:price) { rand(100 + 1) }

    it "assigns price value to variable @price" do
      expect(Shop::Product.new(nil, price).price).to eql(price)
    end

    it "raises ArgumentError if price is <= 0" do
      expect{
        Shop::Product.new(nil, 0)
      }.to raise_error(ArgumentError)
    end

    context ":gross_price" do
      it "returns a floating point number" do
        expect(Shop::Product.new(10, 1).gross_price).to be_a(Float)
      end
    end
  end

  context ":vat" do
    let(:vat) { rand(3) }

    it "assigns vat level == 1 to variable @vat if none provided" do
      expect(Shop::Product.new(nil, 1).vat).to eql(1)
    end

    it "assigns vat value to variable @vat" do
      expect(Shop::Product.new(nil, 1, vat).vat).to eql(vat)
    end
  end

  context ":id" do
    it "assings a fixnum id to variable @id" do
      expect(Shop::Product.new(nil, 1).id).to be_a(Fixnum)
    end
  end

  context "#next_id" do
    it "class variable @@id is incremented" do
      product1 = Shop::Product.new(nil, 1)
      expect(Shop::Product.class_variable_get(:@@id)).to be > 0
    end
  end
end
