class UsersController < ApplicationController

  def index
    render json: { status: true, data: User.all }
  end

  def show
    params = show_user_params

    if params[:id]
      user = User.find(Integer(params[:id]))

      render json: { status: true, data: {
          user: user,
          accounts: user.accounts,
          fingerprints: user.fingerprints
      }}
    else
      render_invalid_parameters
    end
  end

  def create
    params = create_user_params

    signatory_details = params[:signatory_details]
    fingerprint = params[:fingerprint]

    if [signatory_details[:first_name], signatory_details[:middle_name], signatory_details[:surname],
        signatory_details[:email], signatory_details[:phone_number], fingerprint[:fpos], fingerprint[:nfig],
        fingerprint[:base64_template]].none?(&:nil?)

      res = User.attempt_registration(signatory_details, fingerprint)

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

  def list_fingerprints
    render json: { status: true, data: Fingerprint.all }
  end

  private
  def create_user_params
    params.require(:signatory_details)
        .permit(:first_name, :middle_name, :surname, :status, :phone_number, :email)

    params.require(:fingerprint)
        .permit(:fpos, :nfig, :base64_template)

    params
  end

  def show_user_params
    params.permit :id
  end
end