class OrdersController < ApplicationController
  def index
     @item = Item.find(params[:furima_id])
  end
  
  def create
    @record_address = RecordAddress.new(record_params)
    if @record_address.valid?
       @record_address.save
       redirect_to root_path
    else
      render :index
    end
  end

  private

  def record_params
    params.require(:record_address).permit(:potal_code, :prefecture_id, :city, :address, :building, :phone_number).merge(user_id: current_user.id,item_id: current_item.id)
  end

end
