require_relative("./fetch_basket_item")

module Shop
  class RemoveBasketItem
    attr_reader :product_id, :quantity

    def initialize(params)
      @product_id = params.fetch("product_id").to_i
      @quantity = params.fetch("quantity").to_i
    end

    def call
      item = FetchBasketItem.new.call(product_id)

      return unless item

      reduce_basket_quantity(item, quantity)
    end

    private
    def reduce_basket_quantity(item, quantity)
      if item.quantity > quantity
        item.quantity -= quantity
      else
        BASKET.delete(item)
      end
    end
  end
end
