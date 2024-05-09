class Item < ApplicationRecord
  belongs_to :user
  has_one    :order

  validates :image, presence: true
  validates :item_name, presence: true
  validates :item_description, presence: true
  validates :item_price, presence: true

end
