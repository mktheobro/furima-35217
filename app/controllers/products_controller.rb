class ProductsController < ApplicationController
  before_action :search_product, only: [:index, :search]

  def index
    @items = Item.all
    set_product_column
  end

  def search
    @results = @p.result.includes(:user)  # 検索条件にマッチした商品の情報を取得

  end

  private

  def search_product
    @p = Item.ransack(params[:q])  # 検索オブジェクトを生成
  end

  def set_product_column
    @item_name = Item.select("name").distinct  # 重複なくnameカラムのデータを取り出す
  end

end
