# frozen_string_literal: true

class Retweet < ApplicationRecord
  belongs_to :tweet
  belongs_to :user
end
