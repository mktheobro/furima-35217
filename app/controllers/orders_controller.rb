class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :contributor_confirmation, only: [:index, :create]

  def index
    @record_address = RecordAddress.new
  end

  def create
    @record_address = RecordAddress.new(record_params)
    if @record_address.valid?
      pay_item
      @record_address.save
      redirect_to root_path
    else
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

  def contributor_confirmation
    @item = Item.find(params[:item_id])
    if current_user.id == @item.user_id || @item.record.present? 
    redirect_to root_path 
    end
  end

end