# frozen_string_literal: true

class Comment < ApplicationRecord
  attribute :notice_type_id, default: -> { NoticeType.find_by(notice_name: 'コメント').id }
  belongs_to :parent_tweet, class_name: 'Tweet'
  belongs_to :comment_tweet, class_name: 'Tweet'
  belongs_to :notice_type

end
