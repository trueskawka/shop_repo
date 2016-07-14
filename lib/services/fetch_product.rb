module Shop
  class FetchProduct
    def call(id)
      return unless id
      PRODUCTS.find { |product| product.id == id.to_i }
    end
  end
end
