class LogsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    Log.create(log_params)

    render json: {}, status: 200
  end

  private

  def log_params
    params.require(:log).permit(:order_id, :app_name, :carrier_service)
  end
end
