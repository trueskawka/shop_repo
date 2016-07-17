require "web_helper"

RSpec.describe "GET /contact", type: :request do
  before do
    do_request
  end

  it "returns a 404 HTTP code" do
    expect(last_response.status).to eql(404)
  end

  it "returns valid html Content-Type" do
    expect(last_response.headers["Content-Type"]).to include("text/html")
  end

  it "returns a h1 element" do
    expect(last_response.body).to include("<h1>Ooops!</h1>")
  end

  private
  def do_request
    get "/non_existent_site"
  end
end
