# frozen_string_literal: true

module Api
  module V1
    class TweetsController < ApplicationController
      def create
        new_tweet = current_api_v1_user.tweets.build(tweet_params)
        if new_tweet.save
          render json: { status: :created, tweet: new_tweet },
                 status: :ok
        else
          render json: { status: :unprocessable_entity, errors: new_tweet.errors },
                 status: :unprocessable_entity
        end
      end

      private

      def tweet_params
        params.require(:tweet).permit(:content)
      end
    end
  end
end
