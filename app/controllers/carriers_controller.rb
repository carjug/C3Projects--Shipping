class CarriersController < ApplicationController
  def show
    carrier = Carrier.find_by(id: params[:id])

    render json: carrier
  end
end
