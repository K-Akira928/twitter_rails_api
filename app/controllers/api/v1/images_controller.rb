# frozen_string_literal: true

module Api
  module V1
    class ImagesController < ApplicationController
      def update
        tweet = current_api_v1_user.tweets.find(params[:id])
        if tweet.update(image_params)
          render json: { status: :updated },
                 status: :ok
        else
          render json: { status: :unprocessable_entity, errros: tweet.errors },
                 status: :unprocessable_entity
        end
      end

      private

      def image_params
        params.require(:tweet).permit(images: [])
      end
    end
  end
end
