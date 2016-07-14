module Shop
  class FetchBasketItem
    def call(id)
      return unless id
      BASKET.find { |item| item.product_id == id.to_i }
    end
  end
end
