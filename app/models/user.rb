# frozen_string_literal: true

class User < ApplicationRecord
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

  def icon_url
    { icon: icon.attached? ? url_for(icon) : nil }
  end

  def header_url
    { header: header.attached? ? url_for(header) : nil }
  end

  def hash_data
    { user: JSON.parse(to_json).merge(icon_url).merge(header_url) }
  end

  include DeviseTokenAuth::Concerns::User
end
