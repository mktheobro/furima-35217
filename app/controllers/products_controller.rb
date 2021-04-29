class ProductsController < ApplicationController
  before_action :search_product, only: [:index, :search]

  def index
    # @items = Item.all.order("created_at DESC")
    # set_product_column
    # set_tag_column
    # @users = User.all
    @tags = Tag.all
    @items = @p.result.includes(:user, :tags)
  end

  def search
    # @results = @p.result.includes(search_params)  # 検索条件にマッチした商品の情報を取得
    @p = Item.search(search_params)
    @items = @p.result.includes(:user, :tags)
  end

  private

  def search_product
    @p = Item.ransack(params[:q])  # 検索オブジェクトを生成
  end

  def search_params
     params.require(:q).permit(:name_cont, :price_lteq, :category_id_eq, :sales_status_id_eq, :shipping_fee_status_id_eq, :scheduled_delivery_id_eq, :tags_id_eq)
  end

  # def set_tag_column
    # @item_tags = ItemTagRelation.select("tag_id").distinct
  # end

end
