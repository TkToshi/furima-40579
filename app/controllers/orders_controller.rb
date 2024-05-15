class OrdersController < ApplicationController
  before_action :order_to_index, onlry: :index
  before_action :authenticate_user!

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    if @item.order.present?
      redirect_to root_path
    end
    @order_residence = OrderResidence.new
  end

  def create
    @item = Item.find(params[:item_id])
    @order_residence = OrderResidence.new(order_residence_params)
    if @order_residence.valid?
      pay_item = @item
      @order_residence.save
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_residence_params
    params.require(:order_residence).permit(:post_code, :prefecture_id, :municipality, :house_number, :building_name, :phone_number, \
                                            :order_id).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  # 自身のPAY.JPテスト秘密鍵
       Payjp::Charge.create(
         amount: @item.price,  # 商品の値段
         card: order_residence_params[:token],    # カードトークン
         currency: 'jpy'                 # 通貨の種類（日本円）
       )
  end

  def order_to_index
    @item = Item.find(params[:item_id])
    return unless user_signed_in?
    return unless current_user.id == @item.user_id
    redirect_to root_path
    
  end

end
