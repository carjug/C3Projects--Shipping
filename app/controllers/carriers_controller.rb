require 'active_shipping'

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
    fedex_shipping

    @rates = @response.rates

    render json: {}
  end

  def fedex_shipping
      @response = FEDEX.find_rates(params[:origin], params[:destination], params[:packages])
  end
end
