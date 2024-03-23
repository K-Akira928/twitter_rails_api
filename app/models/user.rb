# frozen_string_literal: true

class User < ApplicationRecord
  include Rails.application.routes.url_helpers
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[\d])\w{6,12}\z/

  validates :name, presence: true, length: { maximum: 16 }, uniqueness: true
  validates :nickname, presence: true
  validates :phone, presence: true, format: { with: /\A[0-9]+\z/ }
  validates :birthday, presence: true

  has_many :tweets, dependent: :destroy

  has_one_attached :icon
  has_one_attached :header

  has_many(
    :follows,
    class_name: 'Follow',
    foreign_key: :follower_user_id,
    dependent: :destroy,
    inverse_of: :follower_user
  )
  has_many :follow_users, through: :follows, source: :follow_user

  has_many(
    :followers,
    class_name: 'Follow',
    foreign_key: :follow_user_id,
    dependent: :destroy,
    inverse_of: :follow_user
  )
  has_many :follower_users, through: :followers, source: :follower_user

  has_many(
    :noticeds,
    class_name: 'Notice',
    foreign_key: :noticed_user_id,
    dependent: :destroy,
    inverse_of: :noticed_user
  )
  has_many :noticed_users, through: :noticeds, source: :notice_user

  has_many(
    :notices,
    class_name: 'Notice',
    foreign_key: :notice_user_id,
    dependent: :destroy,
    inverse_of: :notice_user
  )
  has_many :notice_users, through: :notices, source: :noticed_user

  def icon_url
    { icon: icon.attached? ? url_for(icon) : nil }
  end

  def header_url
    { header: header.attached? ? url_for(header) : nil }
  end

  def hash_data(current_user)
    { user: JSON.parse(to_json).merge(icon_url).merge(header_url).merge(user_action(current_user)) }
  end

  def user_action(current_user)
    { action: {
      follow: follow_action(current_user)
    } }
  end

  def follow_action(current_user)
    follower_users.include?(current_user)
  end

  include DeviseTokenAuth::Concerns::User
end
