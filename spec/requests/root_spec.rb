require "web_helper"

RSpec.describe "GET /", type: :request do
  before do
    do_request
  end

  it "returns 200 HTTP code" do
    expect(last_response.status).to eql(200)
  end

  it "returns valid html Content-Type" do
    expect(last_response.headers["Content-Type"]).to include("text/html")
  end

  it "returns h1 element with 'Kitten shop' value" do
    expect(last_response.body).to include("<h1>Kitten shop</h1>")
  end

  it "returns link to home page" do
    expect(last_response.body).to include(
        "<a href=\"/\">
          <button class=\"btn btn-warning menu-button\">
            Purrfect products
          </button>
        </a>"
      )
  end

  it "returns link to basket" do
    expect(last_response.body).to include(
        "<a href=\"/basket\">
          <button class=\"btn btn-warning menu-button\">
            Kitten basket
          </button>
        </a>"
      )
  end

  it "returns link to contact page" do
    expect(last_response.body).to include(
        "<a href=\"/contact\">
          <button class=\"btn btn-warning menu-button\">
            Contact us
          </button>
        </a>"
      )
  end

  private
  def do_request
    get "/"
  end
end
