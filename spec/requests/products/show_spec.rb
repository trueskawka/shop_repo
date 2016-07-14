require "web_helper"

RSpec.describe "GET /products/:id", type: :request do
  context "without existing product" do
    before do
      do_request(100)
    end

    it "returns 404 HTTP code" do
      expect(last_response.status).to eql(404)
    end

    it "returns valid html Content-Type" do
      expect(last_response.headers["Content-Type"]).to include("text/html")
    end
  end

  context "with existing product" do
    let(:product) { Shop::FetchProducts.new.call.first }

    before do
      do_request(product.id)
    end

    it "returns 200 HTTP code" do
      expect(last_response.status).to eql(200)
    end

    it "returns valid html Content-Type" do
      expect(last_response.headers["Content-Type"]).to include("text/html")
    end

    it "contains product name" do
      expect(last_response.body).to include("#{product.name}")
    end
  end

  private
  def do_request(id)
    get "/products/#{id}"
  end
end
