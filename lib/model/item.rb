require_relative("./vat.rb")

module Shop
  class Item
    attr_reader :product_id, :id
    attr_accessor :quantity

    @@id = 0

    def initialize(product_id:, quantity:)
      if !(quantity >= 0)
        raise(ArgumentError)
      else
        @id = new_id
        @product_id = product_id
        @quantity = quantity
      end
    end

    def fetch_product
      FetchProduct.new.call(product_id)
    end

    def total_net_price
      product = fetch_product
      (product.price * quantity).round(2)
    end

    def total_gross_price
      product = fetch_product
      (product.gross_price * quantity).round(2)
    end

    private
    def new_id
      @@id += 1
    end
  end
end
