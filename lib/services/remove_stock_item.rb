require_relative("./fetch_stock_item")

module Shop
  class RemoveStockItem
    attr_reader :product_id, :quantity

    def initialize(params)
      @product_id = params.fetch("product_id").to_i
      @quantity = params.fetch("quantity").to_i
    end

    def call
      item = FetchStockItem.new.call(product_id)

      return unless item

      reduce_stock_quantity(item, quantity)
    end

    private
    def reduce_stock_quantity(item, quantity)
      if item.quantity > quantity
        item.quantity -= quantity
      else
        item.quantity = 0
      end
    end
  end
end
