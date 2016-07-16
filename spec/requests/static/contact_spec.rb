require "web_helper"

RSpec.describe "GET /contact", type: :request do
  before do
    do_request
  end

  it "returns 200 HTTP code" do
    expect(last_response.status).to eql(200)
  end

  it "returns valid html Content-Type" do
    expect(last_response.headers["Content-Type"]).to include("text/html")
  end

  it "returns an img element" do
    expect(last_response.body).to include("<img class=\"img-responsive\" src=\"\/img\/kittens.jpg\" \/>")
  end

  it "returns a h3 element" do
    expect(last_response.body).to include("<h3>Kitty Kittendottir</h3>")
  end

  private
  def do_request
    get "/contact"
  end
end
