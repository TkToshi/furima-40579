class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :birthday, presence: true

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i
  validates_format_of :password, with: PASSWORD_REGEX

  VALID_NAME_REGEX = /\A[ぁ-んァ-ン一-龥]+\z/
  validates :last_name, presence: true, format: { with: VALID_NAME_REGEX }
  validates :first_name, presence: true, format: { with: VALID_NAME_REGEX }

  VALID_KANA_REGEX = /\A[ァ-ヶー－]+\z/
  validates :read_last_name, presence: true, format: { with: VALID_KANA_REGEX }
  validates :read_first_name, presence: true, format: { with: VALID_KANA_REGEX }
end
