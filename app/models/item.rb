class Item < ApplicationRecord
  belongs_to :user
  has_one    :record
  has_one_attached :image
  has_many :item_tag_relations
  has_many :tags, through: :item_tag_relations

  # with_options presence: true do
  #   validates :name
  #   validates :info
  #   with_options numericality: { other_than: 1 } do
  #     validates :category_id
  #     validates :sales_status_id
  #     validates :shipping_fee_status_id
  #     validates :prefecture_id
  #     validates :scheduled_delivery_id
  #   end
  #   validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }

  #   validates :image
  # end

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :sales_status
  belongs_to :shipping_fee_status
  belongs_to :prefecture
  belongs_to :scheduled_delivery
end
