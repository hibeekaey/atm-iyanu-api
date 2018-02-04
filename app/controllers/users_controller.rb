class UsersController < ApplicationController

  def create

  end

  private
  def create_user_params
    params.permit :first_name, :middle_name, :surname,
                  :status, :phone_number, :email
  end
end