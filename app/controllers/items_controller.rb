class ItemsController < ApplicationController
  before_action :set_item, only: :edit
  before_action :move_to_index, except: [:index, :new, :create, :show, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @items = Item.all.order('created_at DESC')
    # @order = Order.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    if @item.save
      redirect_to item_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def move_to_index
    return unless user_signed_in?
    return if current_user.id == @item.user_id

    redirect_to action: :index
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:image, :item_name, :item_description, :item_category_id, :item_condition_id, :shipping_fee_id, \
                                 :prefecture_id, :shipping_day_id, :item_price).merge(user_id: current_user.id)
  end
end
