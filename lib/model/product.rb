module Shop
  class Product
    attr_reader :name, :price, :id, :vat

    @@id = 0

    def initialize(name, price, vat = 1)
      if !(price > 0)
        raise(ArgumentError)
      else
        @id = next_id
        @name = name
        @price = price
        @vat = vat
      end
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
