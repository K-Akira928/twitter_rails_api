# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      def show
        user = User.find_by(name: params[:name])
        tweets = Tweet.convert_hash_data(user.tweets.related_preload.created_sort)

        render json: { user: user.hash_data[:user], tweets:, is_current_user: user == current_api_v1_user },
               status: :ok
      end

    end
  end
end

