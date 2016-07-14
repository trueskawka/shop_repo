module Shop
  class FetchStockItem
    def call(item_id)
      STOCK.find do |item|
        item.product_id == item_id
      end
    end
  end
end
