# frozen_string_literal: true

class Comment < ApplicationRecord
  attribute :notice_type_id, default: -> { NoticeType.find_by(notice_name: 'コメント').id }
  before_create :comment_notice

  belongs_to :parent_tweet, class_name: 'Tweet'
  belongs_to :comment_tweet, class_name: 'Tweet'
  belongs_to :notice_type

  def comment_notice
    noticed_user_id = Tweet.find(parent_tweet_id).user.id
    notice_user_id = Tweet.find(comment_tweet_id).user.id
    return if noticed_user_id == notice_user_id

    Notice.create!(
      noticed_user_id:,
      notice_user_id:,
      tweet_id: Tweet.find(comment_tweet_id).id,
      notice_type_id:
    )
  end
end
