# frozen_string_literal: true

class Favorite < ApplicationRecord
  belongs_to :tweet
  belongs_to :user
  belongs_to :notice_type

end
