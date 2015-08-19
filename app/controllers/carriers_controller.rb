class CarriersController < ApplicationController
  FEDEX = ActiveShipping::FedEx.new(
    login: ENV["FEDEX_LOGIN"],
    password: ENV["FEDEX_PASSWORD"],
    meter: ENV["FEDEX_METER"],
    key: ENV["FEDEX_KEY"],
    account: ENV["FEDEX_ACCT_NUM"],
    test: true
  )

  
  def index

  end
end
