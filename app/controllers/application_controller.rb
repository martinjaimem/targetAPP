class ApplicationController < ActionController::Base
  # GET /status
  def status
    render json: { 'online': true }
  end
end
