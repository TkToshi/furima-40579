class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :read_last_name, presence: true
  validates :read_first_name, presence: true
  validates :birthday, presence: true
  validates :password,
            format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: ' is invalid. Include both letters and numbers' }
  validates :last_name, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: ' is invalid. Input full-width characters' }
  validates :first_name, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: ' is invalid. Input full-width characters' }
  validates :read_last_name, format: { with: /\A[ァ-ヶー－]+\z/, message: ' is invalid. Input full-width katakana characters' }
  validates :read_first_name, format: { with: /\A[ァ-ヶー－]+\z/, message: ' is invalid. Input full-width katakana characters' }
end
