module Shop
  class Product
    attr_reader :name, :price, :id, :vat

    @@id = 0

    def initialize(name, price, vat = 1)
      raise(ArgumentError) unless price > 0

      @id = next_id
      @name = name
      @price = price
      @vat = vat
    end

    def gross_price
      ((Shop::Vat::LEVELS[vat - 1] + 1) * price).round(2)
    end

    private
    def next_id
      @@id += 1
    end
  end
end
