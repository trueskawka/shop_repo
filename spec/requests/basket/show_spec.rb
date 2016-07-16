require "web_helper"
require_relative("../../../lib/model/product")
require_relative("../../../lib/model/item")
require_relative("../../../lib/services/fetch_product")

RSpec.describe "GET /basket", type: :request do
  before do
    stub_const("Shop::PRODUCTS", [Shop::Product.new('Cat food', 3.50, 2)])
    do_request
  end

  it "returns 200 HTTP code" do
    expect(last_response.status).to eql(200)
  end

  it "returns valid html Content-Type" do
    expect(last_response.headers["Content-Type"]).to include("text/html")
  end

  context "empty basket" do
    before do
      stub_const("Shop::BASKET", [])
    end

    it "returns p element with empty basket message" do
      expect(last_response.body).to include("<p>Your basket is empty!</p>")
    end
  end

  context "basket with items" do
    before do
      stub_const("Shop::BASKET", [Shop::Item.new(product_id: Shop::PRODUCTS[0].id, quantity: 2)])
      do_request
    end

    it "does not return p element with empty basket message" do
      expect(last_response.body).not_to include("<p>Your basket is empty!</p>")
    end

    it "returns a table with items" do
      expect(last_response.body).to include("<table width=\"100%\">")
    end
  end

  private
  def do_request
    get "/basket"
  end
end
