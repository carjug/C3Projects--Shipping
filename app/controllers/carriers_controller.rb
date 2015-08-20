require 'active_shipping'
class CarriersController < ApplicationController

  skip_before_filter :verify_authenticity_token

  before_action :cast_to_i, if: -> { Rails.env.test? }

  SERVICE = ["FedEx 2 Day"]
  # FedEx First Overnight
  # FedEx Priority Overnight
  # FedEx Standard Overnight
  # FedEx 2 Day Am
  # FedEx 2 Day
  # FedEx Express Saver
  # FedEx 2 Day Saturday Delivery
  # FedEx Ground Home Delivery

  FEDEX = ActiveShipping::FedEx.new(
    login:    ENV["FEDEX_LOGIN"],
    password: ENV["FEDEX_PASSWORD"],
    meter:    ENV["FEDEX_METER"],
    key:      ENV["FEDEX_KEY"],
    account:  ENV["FEDEX_ACCT_NUM"],
    test:     true
  )

  def index
    fedex_shipping(params[:origin], params[:destination], params[:packages])
    @rates = @response.rates

    @rates.each do |rate|
      if SERVICE.include?(rate.service_name)
        @rate = rate
      end
    end
    binding.pry
    render json: @rate
  end

  def fedex_shipping(origin, destination, packages)
    origin      = set_origin
    destination = set_destination
    packages    = set_packages(params[:packages])
    @response   = FEDEX.find_rates(origin, destination, packages)
  end

  def set_origin
    # binding.pry
    ActiveShipping::Location.new(
      city:    params[:origin][:city],
      state:   params[:origin][:state],
      zip:     params[:origin][:zip],
      country: params[:origin][:country]
    )
  end

  def set_destination
    ActiveShipping::Location.new(
      city:    params[:destination][:city],
      state:   params[:destination][:state],
      zip:     params[:destination][:zip],
      country: params[:destination][:country]
    )
  end

  def set_packages(array)
    packages = []
    array.each do |p|
      package = ActiveShipping::Package.new(
        p[0],
        p[1]
        )
      packages << package
    end
    return packages
  end

  def cast_to_i
    params[:packages] = params[:packages].each do |param|
      param[0] = param[0].to_i
      param[1].each_with_index do |dimension, index|
          param[1][index] = dimension.to_i
      end
    end
  end
end



# set fedex_shipping endpoint in routes
# create a new origin
# create a new destination
# create new packages with the info from bEtsy
