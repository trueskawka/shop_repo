module Shop
  class FetchStockItem
    def call(item_id)
      return unless item_id
      
      STOCK.find { |item| item.product_id == item_id.to_i }
    end
  end
end
