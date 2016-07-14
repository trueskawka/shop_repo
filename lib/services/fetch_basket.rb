module Shop
  class FetchBasket
    def call
      BASKET.map do |item|
        {
          product: item.fetch_product,
          quantity: item.quantity,
          total_net_price: item.total_net_price,
          total_gross_price: item.total_gross_price
        }
      end
    end
  end
end
