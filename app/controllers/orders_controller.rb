class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @record_address = RecordAddress.new
  end

  def create
    @item = Item.find(params[:item_id])
    @record_address = RecordAddress.new(record_params)
    if @record_address.valid?
      pay_item
      @record_address.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render :index
    end
  end

  private

  def record_params
    params.require(:record_address).permit(:potal_code, :prefecture_id, :city, :address, :building, :phone_number, :record_id).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: record_params[:token],
      currency: 'jpy'
    )
  end
end
