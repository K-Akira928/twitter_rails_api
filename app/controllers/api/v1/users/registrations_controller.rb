# frozen_string_literal: true

module Api
  module V1
    module Users
      class RegistrationsController < DeviseTokenAuth::RegistrationsController
        private

        def sign_up_params
          params.permit(:name, :nickname, :email, :phone, :birthday, :password, :password_confirmation)
        end
      end
    end
  end
end
