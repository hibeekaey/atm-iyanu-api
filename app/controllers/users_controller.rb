class UsersController < ApplicationController

  def show
    params = show_user_params

    if params[:id]
      user = User.find(Integer(params[:id]))

      render json: { status: true, data: {
          user: user,
          accounts: user.accounts
      }}
    else
      render_invalid_parameters
    end
  end

  def create
    params = create_user_params

    if [params[:first_name], params[:middle_name], params[:surname],
        params[:email], params[:phone_number]].none?(&:nil?)

      res = User.attempt_registration(params[:first_name],
                                      params[:surname],
                                      params[:middle_name],
                                      params[:email],
                                      params[:phone_number])

      if res[:exec_status]
        render json: { status: true, data: res[:data] }, status: :created
      else
        render json: { status: false, data: {
            message: 'Unable to create user at the moment.'
        }}
      end
    else
      render json: { status: false, data: {
          message: 'Invalid parameters'
      }}, status: :bad_request
    end
  end

  private
  def create_user_params
    params.permit :first_name, :middle_name, :surname,
                  :status, :phone_number, :email
  end

  def show_user_params
    params.permit :id
  end
end