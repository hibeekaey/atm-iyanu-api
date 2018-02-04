class ApplicationController < ActionController::API

  private
  def render_invalid_parameters
    render json: { status: false, data: {
        message: 'Invalid or incomplete parameter payload'
    }}, status: :bad_request
  end
end
