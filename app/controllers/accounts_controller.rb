class AccountsController < ApplicationController

  def create

  end

  private
  def create_account_params
    params.permit :name, :number, :status
  end
end