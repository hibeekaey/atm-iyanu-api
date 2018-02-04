class TransactionsController < ApplicationController

  def withdraw
    params = withdraw_transaction_params

    if params[:account_id] && params[:amount]
      res = Account.withdraw_amount(params[:account_id], params[:amount])

      case res[:exec_status]
        when 'withdraw_success'
          render json: { status: true, data: {
              account: res[:data]
          }}
        when 'withdraw_failure'
          render json: { status: false, data: {
              message: res[:data]
          }}
        when 'insufficient_funds'
          render json: { status: false, data: {
              message: res[:data]
          }}
        when 'invalid_account_id'
          render json: { status: false, data: {
              message: res[:data]
          }}, status: :unprocessable_entity
      end
    else
      render_invalid_parameters
    end
  end

  def credit
    params = credit_account_params

    if params[:account_number] && params[:amount]
      res = Account.credit_account(params[:account_number], params[:amount])

      case res[:exec_status]
        when 'credit_success'
          render json: { status: true, data: {
              account: res[:data]
          }}
        when 'credit_failed'
          render json: { status: false, data: {
              message: res[:data]
          }}
        when 'invalid_account_number'
          render json: { status: false, data: {
              message: res[:data]
          }}, status: :unprocessable_entity
      end
    else
      render_invalid_parameters
    end
  end

  private
  def credit_account_params
    params.permit :account_number, :amount
  end

  def withdraw_transaction_params
    params.permit :account_id, :amount
  end
end
