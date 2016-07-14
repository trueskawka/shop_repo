require_relative("./fetch_basket_item")

module Shop
  class AddBasketItem
    attr_reader :product_id, :quantity

    def initialize(params)
      @product_id = params.fetch("product_id").to_i
      @quantity = params.fetch("quantity").to_i
    end

    def call
      item = FetchBasketItem.new.call(product_id)

      if !item
        BASKET << Item.new(product_id: product_id, quantity: quantity)
      else
        increase_item_quantity(item, quantity)
      end
    end

    private
    def increase_item_quantity(item, quantity)
      item.quantity += quantity
    end

  end
end
