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

  include DeviseTokenAuth::Concerns::User
end
