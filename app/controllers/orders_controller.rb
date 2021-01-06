class OrdersController < ApplicationController
  before_action :authenticate_user!, only: :index
  before_action :find_item
  before_action :move_to_index, only: :index

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_address_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render :index
    end
  end

  private

  def order_address_params
    params.require(:order_address).permit(
      :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number
    ).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_address_params[:token],
      currency: 'jpy'
    )
  end

  def move_to_index
    redirect_to root_path if current_user.id == @item.user_id || @item.order
  end

  def find_item
    @item = Item.find(params[:item_id])
  end
end
