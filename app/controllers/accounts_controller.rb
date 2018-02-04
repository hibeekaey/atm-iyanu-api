class AccountsController < ApplicationController

  def create
    params = create_account_params

    if params[:user_id] && params[:account_name]
      res = Account.attempt_creation(params[:user_id],
                                     params[:account_name], params[:status])

      if res[:exec_status]
        render json: { status: true, data: {
            account: res[:data]
        } }, status: :created
      else
        render json: { status: false, data: {
            message: 'Unable to create account at the moment'
        }}
      end
    else
      render_invalid_parameters
    end
  end

  def show
    params = show_account_params

    if params[:id]
      render json: { status: true, data: Account.find(id) }
    else
      render_invalid_parameters
    end
  end

  private
  def create_account_params
    params.permit :user_id, :account_name, :status
  end

  def show_account_params
    params.permit :id
  end
end