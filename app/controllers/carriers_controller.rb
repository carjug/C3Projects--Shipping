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
    origin      = set_origin
    destination = set_destination
    packages    = set_packages

    @response = FEDEX.find_rates(origin, destination, packages)
  end

  def set_origin(city, state, zip, country)
    ActiveShipping::Location.new(
      city: city,
      state: state,
      zip: zip,
      country: country
      )
  end

  def set_destination(city, state, zip, country)
    ActiveShipping::Location.new(
      city: city,
      state: state,
      zip: zip,
      country: country
      )
  end

  def set_packages(array)
    packages = []
    array.each do |p|
      package = ActiveShipping::Package.new(
        # p.weight
        # p.array of dimensions
        )
      packages << package
    end
    return packages
  end
end

# set fedex_shipping endpoint in routes
# create a new origin
# create a new destination
# create new packages with the info from bEtsy
