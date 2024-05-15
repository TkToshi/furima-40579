class OrderResidence
  include ActiveModel::Model
  attr_accessor :token, :user_id, :item_id, :post_code, :prefecture_id, :municipality, :house_number, :building_name, :phone_number

  with_options presence: true do
    validates :item_id, presence: true
    validates :user_id, presence: true
    validates :token, presence: true
    validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :prefecture_id, numericality: {other_than: 1, message: "can't be blank"}
    validates :municipality, presence: true
    validates :house_number, presence: true
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: "is invalid. Please enter numbers only"}
  end

  def save
    # 購入情報を保存し、変数orderに代入する
    order = Order.create(item_id: item_id, user_id: user_id)
    # 住所を保存する
    # order_idには、変数orderのidと指定する
    Residence.create(post_code: post_code, prefecture_id: prefecture_id, municipality: municipality, house_number: house_number, 
                     building_name: building_name, phone_number: phone_number, order_id: order.id)
  end
end