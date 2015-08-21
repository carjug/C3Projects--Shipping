require 'active_shipping'
class CarriersController < ApplicationController

  skip_before_filter :verify_authenticity_token

  before_action :cast_to_i, if: -> { Rails.env.test? }
  # Trying to get rspec tests to work nicely with numbers

  def index
    origin      = set_origin
    destination = set_destination
    packages    = set_packages(params[:packages])

    fedex_shipping(origin, destination, packages)
    ups_shipping(origin, destination, packages)

    @rates = [@response_fedex.rates, @response_ups.rates ]
    if @rates
      render json: @rates.as_json
    else
      render json: {}, status: 204
    end
  end

  def fedex_shipping(origin, destination, packages)
    fedex = set_fedex
    @response_fedex = fedex.find_rates(origin, destination, packages)
  end

  def ups_shipping(origin, destination, packages)
    ups = set_ups
    @response_ups = ups.find_rates(origin, destination, packages)

  end

  def set_fedex
    ActiveShipping::FedEx.new(
      login:    ENV["FEDEX_LOGIN"],
      password: ENV["FEDEX_PASSWORD"],
      meter:    ENV["FEDEX_METER"],
      key:      ENV["FEDEX_KEY"],
      account:  ENV["FEDEX_ACCT_NUM"],
      test:     true
    )
  end

  def set_ups
    ActiveShipping::UPS.new(
      login:    ENV["UPS_LOGIN"],
      password: ENV["UPS_PASSWORD"],
      key:      ENV["UPS_KEY"],
      test:     true
    )
  end

  def set_origin
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

  # Before action method

  def cast_to_i
    params[:packages] = params[:packages].each do |param|
      param[0] = param[0].to_i
      param[1].each_with_index do |dimension, index|
          param[1][index] = dimension.to_i
      end
    end
  end
end
