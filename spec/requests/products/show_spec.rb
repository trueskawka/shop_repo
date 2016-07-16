require "web_helper"
require_relative("../../../lib/model/product")
require_relative("../../../lib/services/fetch_product")

RSpec.describe "GET /product/:id", type: :request do
  context "existing product" do
    before do
      stub_const("Shop::PRODUCTS", [Shop::Product.new('Cat food', 3.50, 2)])
      item = Shop::PRODUCTS[0].id
      do_request(item)
    end

    it "returns 200 HTTP code" do
      expect(last_response.status).to eql(200)
    end

    it "returns valid html Content-Type" do
      expect(last_response.headers["Content-Type"]).to include("text/html")
    end

    it "returns a form element to post/basket" do
      expect(last_response.body).to include("<form action=\"\/basket\" method=\"post\">")
    end
  end

  context "non-existent product" do
    before do
      do_request(Shop::PRODUCTS.size + 2)
    end

    it "returns 404 HTTP code" do
      expect(last_response.status).to eql(404)
    end
  end

  private
  def do_request(item)
    get "/products/" + item.to_s
  end
end
