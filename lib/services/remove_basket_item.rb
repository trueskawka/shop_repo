require_relative("./fetch_basket_item")

module Shop
  class RemoveBasketItem
    attr_reader :product_id

    def initialize(params)
      @product_id = params.fetch("product_id").to_i
    end

    def call
      item = FetchBasketItem.new.call(product_id)

      return unless item

      BASKET.delete(item)
    end
  end
end
