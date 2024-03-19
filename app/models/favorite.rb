# frozen_string_literal: true

class Favorite < ApplicationRecord
  attribute :notice_type_id, default: -> { NoticeType.find_by(notice_name: 'いいね').id }
  belongs_to :tweet
  belongs_to :user
  belongs_to :notice_type

end
