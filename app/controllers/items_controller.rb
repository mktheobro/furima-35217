class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :contributor_confirmation, only: [:edit, :update, :destroy]

  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = ItemsTag.new
  end

  def create
    @item = ItemsTag.new(item_params)
    if @item.valid?
      @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    if @item.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  def edit
    load_post
    @item = ItemsTag.new(item: @post)
  end

  def update
    load_post
    @item = ItemsTag.new(item_params, item: @post)
    if @item.valid?
      @item.save
      redirect_to item_path(@post.id)
    else
      render :edit
    end
 
  end

  def show
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:name, :info, :category_id, :sales_status_id, :shipping_fee_status_id, :prefecture_id,
                                      :scheduled_delivery_id, :price, :image, :tag_name).merge(user_id: current_user.id)
  end

  def contributor_confirmation
    @item = Item.find(params[:id])
    redirect_to root_path unless current_user.id == @item.user_id && @item.record.nil?
  end

  def load_post
    @post = current_user.items.find(params[:id])
  end

end
