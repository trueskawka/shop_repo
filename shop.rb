require "bundler/setup"
require "sinatra/base"
require "sinatra/reloader"

Dir["./lib/**/*.rb"].each{|file| require file}

module Shop
  PRODUCTS = [
    Product.new('Cat food', 3.50, 2),
    Product.new("Cat toy", 7.50, 3),
    Product.new("Cat litter box", 18.30, 1),
    Product.new("Delivery", 15.0, 4)
  ]

  STOCK = [
    Item.new(product_id: 1, quantity: 10),
    Item.new(product_id: 2, quantity: 50),
    Item.new(product_id: 3, quantity: 13),
    Item.new(product_id: 4, quantity: 10)
  ]

  BASKET = []

  class App < Sinatra::Base
    configure :test do
      set :dump_errors, false
    end

    get "/" do
      products = FetchProducts.new.call
      erb :"products/index", locals: { products: products, title: "Products" }
    end

    get "/products/:id" do |id|
      item = FetchProduct.new.call(id)
      halt 404 unless item
      erb :"products/show", locals: { item: item }
    end

    get "/basket" do
      basket = FetchBasket.new.call
      erb :"basket/show", locals: { basket: basket }
    end

    post "/basket" do
      begin
        AddBasketItem.new(params).call
        RemoveStockItem.new(params).call
        redirect "/"
      rescue KeyError
        halt 422
      end
    end

    post "/basket_remove" do
      RemoveBasketItem.new(params).call
      AddStockItem.new(params).call
      redirect "/basket"
    end

    get "/contact" do
      erb :"static/contact"
    end

    not_found do
      status 404
      erb :"static/404"
    end
  end
end
