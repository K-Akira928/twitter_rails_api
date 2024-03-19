# frozen_string_literal: true

class Follow < ApplicationRecord
  attribute :notice_type_id, default: -> { NoticeType.find_by(notice_name: 'フォロー').id }
  belongs_to :follow_user, class_name: 'User'
  belongs_to :follower_user, class_name: 'User'
  belongs_to :notice_type

end
