class Api::V1::Users::RegistrationsController < DeviseTokenAuth::RegistrationsController
  private

  def sign_up_params
    params.permit(:name, :nickname, :email, :phone, :birthday, :password, :password_confirmation)
  end
end
