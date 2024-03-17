# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      before_action :set_current_user, only: %i[show follow]
      def show
        user = User.find_by(name: params[:name])
        tweets = Tweet.convert_hash_data(tweets_by_tab(user, params[:tab]), @current_user)

        render json: { user: user.hash_data(@current_user)[:user], tweets:, is_current_user: user == @current_user },
               status: :ok
      end

      def update
        user = current_api_v1_user

        if user.update(user_params)
          render json: { status: :updated },
                 status: :ok
        else
          render json: { errors: user.errors },
                 status: :unprocessable_entity
        end
      end

      def follow
        follow_user = User.find_by(name: params[:name])
        follows = current_api_v1_user.follows.build(follow_user_id: follow_user.id)
        if follows.save
          render json: { status: :follow },
                 status: :ok
        else
          render json: { messages: 'フォローに失敗しました' },
                 status: :bad_request
        end
      end

      private

      def user_params
        params.require(:user).permit(:header, :icon, :nickname, :bio, :location, :website, :phone)
      end

      def set_current_user
        @current_user = current_api_v1_user
      end

      def tweets_by_tab(user, tab)
        case tab
        when 'tweets'
          user.tweets.not_comment_tweets
        when 'comments'
          user.tweets.comment_tweets
        end
      end
    end
  end
end
