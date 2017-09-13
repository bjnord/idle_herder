class ErrorsController < ApplicationController
  def show
    respond_to do |format|
      format.json { render json: {status: 'error', error: Rack::Utils::HTTP_STATUS_CODES[status_code.to_i]}, status: status_code }
      format.html { render status_code.to_s, status: status_code }
    end
  end

protected

  def status_code
    params[:code] || 500
  end
end
