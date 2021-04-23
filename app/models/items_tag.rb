class ItemsTag
  include ActiveModel::Model
  attr_accessor :name, :info, :category_id, :sales_status_id, :shipping_fee_status_id, :prefecture_id, :scheduled_delivery_id,
                :price, :image, :user_id, :tag_name, :item_id, :tag_id

  with_options presence: true do
    validates :name
    validates :info
    validates :tag_name
    with_options numericality: { other_than: 1 } do
      validates :category_id
      validates :sales_status_id
      validates :shipping_fee_status_id
      validates :prefecture_id
      validates :scheduled_delivery_id
    end
    validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }

    validates :image
  end

  

  def save
    item = Item.create(name: name, info: info, category_id: category_id, sales_status_id: sales_status_id,
                       shipping_fee_status_id: shipping_fee_status_id, prefecture_id: prefecture_id, scheduled_delivery_id: scheduled_delivery_id, price: price,user_id: user_id, image: image)
    tag = Tag.where(tag_name: tag_name).first_or_initialize
    tag.save

    ItemTagRelation.create(item_id: item.id, tag_id: tag.id)
  end

  
end
