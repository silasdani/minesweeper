class ApplicationController < ActionController::Base
  include Pagy::Backend

  def ping
    render json: { status: 'pong' }
  end
end
